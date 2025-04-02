import os
import typing

import path_utils
from completers import ICompleter


class TPythonCompleter(ICompleter):
    VENV_NODES: typing.Final[tuple[str, ...]] = (
        os.path.normpath(".venv/bin/python3"),
        os.path.normpath("venv/bin/python3"),
        os.path.normpath("virtualenv/bin/python3"),
    )
    DEFAULT_PYTHON: typing.Final[str] = "python3"

    @classmethod
    def find_python_path(cls, source_dir_path: str) -> str:
        path: typing.Optional[str] = path_utils.bfs_node_upwards(source_dir_path, cls.VENV_NODES)
        return cls.DEFAULT_PYTHON if path is None else path

    @classmethod
    def complete(cls, **kwargs) -> dict:
        filename: str = kwargs["filename"]
        return {"interpreter_path": cls.find_python_path(os.path.dirname(filename))}
