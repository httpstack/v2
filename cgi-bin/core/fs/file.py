import os
import json

class AppException(Exception):
    """Custom exception for file loader errors."""
    pass


class FileLoader:
    def __init__(self, container=None):
        self.container = container
        self.mapped_directories = {}
        self.default_extension = "py"
        self.default_html_extension = "html"
        self.file_cache = {}

    def include(self, class_path: str, **kwargs):
        if not self.container:
            raise AppException("Container not set for FileLoader")
        return self.container.make(class_path, **kwargs)

    def map_directory(self, name: str, directory: str):
        if not os.path.isdir(directory):
            raise AppException(f"Directory not found: {directory}")
        self.mapped_directories[name] = directory.rstrip("/")
        return self

    def get_directory(self, name: str):
        return self.mapped_directories.get(name)

    def get_directories(self):
        return self.mapped_directories

    def find_file(self, name: str, directory: str = None, extension: str = None):
        extension = extension or self.default_extension
        if extension and not os.path.splitext(name)[1]:
            name += f".{extension.lstrip('.')}"
        normalized_name = name.replace("\\", "/")

        dirs_to_search = [self.mapped_directories.get(directory, directory)] if directory else self.mapped_directories.values()

        for dir_path in dirs_to_search:
            if os.path.isdir(dir_path):
                for root, _, files in os.walk(dir_path):
                    for file in files:
                        if file == normalized_name or file.endswith(normalized_name):
                            return os.path.join(root, file)
        return None

    def find_files_by_extension(self, extensions, directory: str = None):
        if isinstance(extensions, str):
            extensions = [extensions]
        found_files = []
        dirs_to_search = [self.mapped_directories.get(directory, directory)] if directory else self.mapped_directories.values()

        for dir_path in dirs_to_search:
            if os.path.isdir(dir_path):
                for root, _, files in os.walk(dir_path):
                    for file in files:
                        if os.path.splitext(file)[1].lstrip(".") in extensions:
                            found_files.append(os.path.join(root, file))
        return list(set(found_files))

    def load_file(self, path: str, use_cache: bool = True):
        if use_cache and path in self.file_cache:
            return self.file_cache[path]

        if path in self.mapped_directories:
            path = self.mapped_directories[path]

        if not os.path.isfile(path):
            found_path = self.find_file(path)
            if not found_path:
                raise AppException(f"File not found: {path}")
            path = found_path

        with open(path, "r", encoding="utf-8") as f:
            content = f.read()

        if use_cache:
            self.file_cache[path] = content
        return content

    def parse_json_file(self, path: str):
        if not os.path.isfile(path):
            raise AppException(f"File not found: {path}")
        with open(path, "r", encoding="utf-8") as f:
            try:
                return json.load(f)
            except json.JSONDecodeError:
                raise AppException(f"Failed to parse JSON file: {path}")

    def write_file(self, path: str, content: str):
        directory = os.path.dirname(path)
        if not os.path.isdir(directory):
            os.makedirs(directory, exist_ok=True)
        with open(path, "w", encoding="utf-8") as f:
            f.write(content)
        self.file_cache[path] = content
        return True

    def read_file(self, base_name: str):
        path = self.find_file(base_name, extension=self.default_html_extension)
        if not path:
            raise AppException(f"File not found: {base_name}")
        with open(path, "r", encoding="utf-8") as f:
            return f.read()

    def set_default_extension(self, extension: str):
        self.default_extension = extension.lstrip(".")
        return self

    def get_default_extension(self):
        return self.default_extension

    def clear_cache(self):
        self.file_cache = {}
        return self

    def exists(self, path: str):
        if path in self.mapped_directories:
            path = self.mapped_directories[path]
        return os.path.isfile(path)

    def handle_duplicates(self, files, strategy="first"):
        result = []
        file_map = {}
        for file in files:
            name = os.path.basename(file)
            file_map.setdefault(name, []).append(file)

        for paths in file_map.values():
            if len(paths) == 1:
                result.append(paths[0])
            else:
                if strategy == "first":
                    result.append(paths[0])
                elif strategy == "last":
                    result.append(paths[-1])
                elif strategy == "all":
                    result.extend(paths)
        return result
