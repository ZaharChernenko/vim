import os
import typing


def bfs_node_upwards(source_dir_path: str, nodes: typing.Collection[str]) -> typing.Optional[str]:
    """
    Searches for specified files/directories in the current directory and its direct ancestors.
    Returns the first matching node found (prioritizing order in nodes list)
    """

    current_dir, next_dir = source_dir_path, os.path.dirname(source_dir_path)
    while current_dir != next_dir:  # until we reach the root
        for node in nodes:
            path_to_node = os.path.join(current_dir, node)
            if os.path.exists(path_to_node):
                return path_to_node
        current_dir = next_dir  # going up
        next_dir = os.path.dirname(current_dir)
    return None


def bfs_newest_node_upwards(source_dir_path: str, nodes: typing.Iterable[str]) -> typing.Optional[str]:
    """
    Same as bfs_node_upwards, but returns the node that is newest by modification date.
    """

    current_dir, next_dir = source_dir_path, os.path.dirname(source_dir_path)
    while current_dir != next_dir:
        newest_path_to_node: typing.Optional[str] = None
        newest_modification_time: typing.Optional[float] = None
        for node in nodes:
            current_path_to_node = os.path.join(current_dir, node)
            if os.path.exists(current_path_to_node):
                current_modification_time: float = os.path.getmtime(current_path_to_node)
                if newest_path_to_node is None or newest_modification_time < current_modification_time:
                    newest_path_to_node = current_path_to_node
                    newest_modification_time = current_modification_time
        if newest_path_to_node is not None:
            return newest_path_to_node
        current_dir = next_dir
        next_dir = os.path.dirname(current_dir)
    return None
