import abc
import os
import typing


class ICompleter(abc.ABC):
    """Abstract base class for completers."""

    @classmethod
    @abc.abstractmethod
    def complete(cls, **kwargs) -> dict:
        raise NotImplementedError()

    @staticmethod
    def find_node_upwards(source_dir_path: str, node: str) -> typing.Optional[str]:
        """Searches for the desired node in the source directory and all ancestors"""

        current_dir, next_dir = source_dir_path, os.path.dirname(source_dir_path)
        while current_dir != next_dir:  # until we reach the root
            path_to_node = os.path.join(current_dir, node)
            if os.path.exists(path_to_node):
                return path_to_node
            current_dir = next_dir  # going up
            next_dir = os.path.dirname(current_dir)
        return None
