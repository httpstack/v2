import importlib
import inspect
from types import FunctionType
from typing import Any, Callable, Type, Optional

class AppException(Exception):
    pass

class Container:
    def __init__(self):
        self.bindings: dict[str, Any] = {}
        self.instances: dict[str, Any] = {}
        self.aliases: dict[str, str] = {}
        self.props: dict[str, Any] = {}

        # Example predefined aliases
        self.aliases.update({
            "ctrl.routes.home": "app.controllers.routes.HomeController",
            "ctrl.routes.contact": "app.controllers.routes.ContactController",
        })

    # register alias or list of aliases pointing to a FQN or class
    def alias(self, alias: str | list[str], fqn_or_type: str | Type):
        fqn = self._normalize_to_fqn(fqn_or_type)
        if isinstance(alias, list):
            for a in alias:
                self.aliases[a] = fqn
        else:
            self.aliases[alias] = fqn

    def bind(self, abstract: str | Type, concrete: Any):
        key = self._normalize_key(abstract)
        self.bindings[key] = concrete

    def singleton(self, abstract: str | Type, concrete: Any):
        key = self._normalize_key(abstract)
        self.bindings[key] = concrete
        self.instances[key] = None

    def make(self, abstract: str | Type, **params) -> Any:
        # If caller passed a class type directly
        if isinstance(abstract, type):
            key = abstract.__module__ + "." + abstract.__name__
            if key in self.instances and self.instances[key] is not None:
                return self.instances[key]
            return self._build_from_class(abstract, params)

        # otherwise handle string (alias or FQN)
        key = str(abstract)
        # alias resolution
        key = self.aliases.get(key, key)
        # if there is an instance cached for singletons
        if key in self.instances and self.instances[key] is not None:
            return self.instances[key]
        # check binding
        concrete = self.bindings.get(key, key)
        return self._resolve_concrete(concrete, key, params)

    def _resolve_concrete(self, concrete: Any, key: str, params: dict) -> Any:
        # callable factory
        if isinstance(concrete, FunctionType) or callable(concrete) and not isinstance(concrete, str):
            # If it's a factory function that expects container, pass it
            try:
                return concrete(self, **params)
            except TypeError:
                return concrete(**params)
        # class object
        if isinstance(concrete, type):
            instance = self._build_from_class(concrete, params)
            if key in self.instances:
                self.instances[key] = instance
            return instance
        # string => FQN
        if isinstance(concrete, str):
            try:
                instance = self._build_from_fqn(concrete, params)
                if key in self.instances:
                    self.instances[key] = instance
                return instance
            except Exception as e:
                raise AppException(f"Failed to resolve '{key}': {e}") from e
        # object instance already
        if isinstance(concrete, object):
            return concrete
        raise AppException(f"Unresolvable dependency type for '{key}'")

    def _build_from_fqn(self, class_path: str, params: dict) -> Any:
        module_path, class_name = class_path.rsplit(".", 1)
        try:
            module = importlib.import_module(module_path)
            cls = getattr(module, class_name)
        except (ImportError, AttributeError) as e:
            raise AppException(f"Class {class_path} not found: {e}") from e
        return self._build_from_class(cls, params)

    def _build_from_class(self, cls: Type, params: dict) -> Any:
        sig = inspect.signature(cls.__init__)
        args = []
        for name, param in sig.parameters.items():
            if name == "self":
                continue
            if name in params:
                args.append(params[name])
            elif param.annotation != inspect.Parameter.empty and isinstance(param.annotation, type):
                dep_class = param.annotation
                args.append(self.make(dep_class))
            elif param.default != inspect.Parameter.empty:
                args.append(param.default)
            else:
                raise AppException(f"Cannot resolve parameter '{name}' for {cls}")
        instance = cls(*args)
        # If class FQN was used as key in singletons, store by its FQN
        fqn = cls.__module__ + "." + cls.__name__
        if fqn in self.instances:
            self.instances[fqn] = instance
        return instance

    def call(self, callback: Callable | tuple | str, parameters: dict | None = None) -> Any:
        parameters = parameters or {}
        if isinstance(callback, (list, tuple)) and len(callback) == 2:
            # support (class or fqn, method_name)
            cls_ref = callback[0]
            method_name = callback[1]
            instance = self.make(cls_ref)
            method = getattr(instance, method_name)
            return self._invoke(method, parameters)
        elif callable(callback):
            return self._invoke(callback, parameters)
        elif isinstance(callback, str) and "::" in callback:
            cls, method = callback.split("::", 1)
            return self.call((cls, method), parameters)
        else:
            raise AppException("Invalid callback provided to container.call()")

    def _invoke(self, func: Callable, parameters: dict) -> Any:
        sig = inspect.signature(func)
        args = []
        for name, param in sig.parameters.items():
            if name in parameters:
                args.append(parameters[name])
            elif param.annotation != inspect.Parameter.empty and isinstance(param.annotation, type):
                args.append(self.make(param.annotation))
            elif param.default != inspect.Parameter.empty:
                args.append(param.default)
            else:
                raise AppException(f"Cannot resolve parameter '{name}' for callable")
        return func(*args)

    def add_property(self, name: str, value: Any):
        self.props[name] = value

    def remove_property(self, name: str):
        self.props.pop(name, None)

    def get_property(self, name: str):
        return self.props.get(name)

    def has_property(self, name: str):
        return name in self.props

    def make_callable(self, handler: Any) -> Callable:
        if callable(handler):
            return handler
        if isinstance(handler, (list, tuple)) and len(handler) == 2:
            instance = self.make(handler[0])
            method = getattr(instance, handler[1])
            return lambda *a, **k: method(*a, **k)
        if isinstance(handler, str):
            if "::" in handler:
                cls, method = handler.split("::", 1)
                return self.make_callable((cls, method))
            # try alias -> FQN or treat as dotted path
            fqn = self.aliases.get(handler, handler)
            if "." in fqn:
                module_path, method_or_class = fqn.rsplit(".", 1)
                try:
                    module = importlib.import_module(module_path)
                    # if it's a function in module
                    if hasattr(module, method_or_class):
                        obj = getattr(module, method_or_class)
                        if callable(obj):
                            return obj
                except ImportError:
                    pass
        raise AppException("Invalid handler provided")

    # helpers
    def _normalize_key(self, abstract: str | Type) -> str:
        if isinstance(abstract, type):
            return abstract.__module__ + "." + abstract.__name__
        return str(abstract)

    def _normalize_to_fqn(self, fqn_or_type: str | Type) -> str:
        if isinstance(fqn_or_type, type):
            return fqn_or_type.__module__ + "." + fqn_or_type.__name__
        return str(fqn_or_type)