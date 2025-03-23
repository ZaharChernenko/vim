import os
import sys
import typing

from . import interface


class TPythonCompleter(interface.ICompleter):
    VENV_NODES: typing.Final[tuple[str, ...]] = (".venv/bin/python3", "venv/bin/python3", "virtualenv/bin/python3")
    DEFAULT_PYTHON3: typing.Final[str] = "python3-intel64" if sys.platform == "darwin" else "python3"

    @classmethod
    def find_python_path_in_filesystem(cls, source_dir_path: str) -> str:
        for node in cls.VENV_NODES:
            path: typing.Optional[str] = cls.find_node_upwards(source_dir_path, node)
            if path is not None:
                return path
        return cls.DEFAULT_PYTHON3

    @classmethod
    def complete(cls, **kwargs) -> dict:
        filename: str = kwargs["filename"]
        return {"interpreter_path": cls.find_python_path_in_filesystem(os.path.dirname(filename))}
