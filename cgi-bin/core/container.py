import importlib
import inspect
from types import FunctionType
from typing import Any, Callable


class AppException(Exception):
    pass


class Container:
    def __init__(self):
        self.bindings = {}
        self.instances = {}
        self.aliases = {}
        self.props = {}

        # Predefined aliases (example)
        self.aliases = {
            "ctrl.routes.home": "app.controllers.routes.HomeController",
            "ctrl.routes.contact": "app.controllers.routes.ContactController",
            # Add more as needed
        }

    def alias(self, alias: str | list[str], fqn: str):
        if isinstance(alias, list):
            for a in alias:
                self.aliases[a] = fqn
        else:
            self.aliases[alias] = fqn

    def bind(self, abstract: str, concrete: Any):
        self.bindings[abstract] = concrete

    def singleton(self, abstract: str, concrete: Any):
        self.bindings[abstract] = concrete
        self.instances[abstract] = None

    def make(self, abstract: str, **params) -> Any:
        if abstract in self.instances and self.instances[abstract] is not None:
            return self.instances[abstract]
        return self.resolve(abstract, params)

    def resolve(self, abstract: str, params: dict) -> Any:
        abstract = self.aliases.get(abstract, abstract)
        concrete = self.bindings.get(abstract, abstract)

        if isinstance(concrete, FunctionType):
            return concrete(self, **params)
        elif isinstance(concrete, object) and not isinstance(concrete, str):
            return concrete
        elif isinstance(concrete, str):
            try:
                return self.build(concrete, params)
            except Exception as e:
                raise AppException(f"Failed to resolve '{abstract}': {e}")
        else:
            raise AppException(f"Unresolvable dependency type for '{abstract}'")

    def build(self, class_path: str, params: dict) -> Any:
        module_path, class_name = class_path.rsplit(".", 1)
        try:
            module = importlib.import_module(module_path)
            cls = getattr(module, class_name)
        except (ImportError, AttributeError) as e:
            raise AppException(f"Class {class_path} does not exist: {e}")

        sig = inspect.signature(cls.__init__)
        args = []
        for name, param in sig.parameters.items():
            if name == "self":
                continue
            if name in params:
                args.append(params[name])
            elif param.annotation != inspect.Parameter.empty:
                dep_class = param.annotation
                args.append(self.make(dep_class.__module__ + "." + dep_class.__name__))
            elif param.default != inspect.Parameter.empty:
                args.append(param.default)
            else:
                raise AppException(f"Cannot resolve parameter '{name}' for {class_path}")

        instance = cls(*args)
        if class_path in self.instances:
            self.instances[class_path] = instance
        return instance

    def call(self, callback: Callable, parameters: dict = None) -> Any:
        parameters = parameters or {}
        if isinstance(callback, (list, tuple)) and len(callback) == 2:
            instance = self.make(callback[0])
            method = getattr(instance, callback[1])
            return self._invoke(method, parameters)
        elif callable(callback):
            return self._invoke(callback, parameters)
        elif isinstance(callback, str) and "::" in callback:
            cls, method = callback.split("::")
            return self.call((cls, method), parameters)
        else:
            raise AppException("Invalid callback provided to container.call()")

    def _invoke(self, func: Callable, parameters: dict) -> Any:
        sig = inspect.signature(func)
        args = []
        for name, param in sig.parameters.items():
            if name in parameters:
                args.append(parameters[name])
            elif param.annotation != inspect.Parameter.empty:
                dep_class = param.annotation
                args.append(self.make(dep_class.__module__ + "." + dep_class.__name__))
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
        elif isinstance(handler, (list, tuple)) and len(handler) == 2:
            instance = self.make(handler[0])
            method = getattr(instance, handler[1])
            return lambda *args, **kwargs: method(*args, **kwargs)
        elif isinstance(handler, str):
            if "::" in handler:
                cls, method = handler.split("::")
                return self.make_callable((cls, method))
            elif handler in globals():
                return globals()[handler]
        raise AppException("Invalid handler provided")
