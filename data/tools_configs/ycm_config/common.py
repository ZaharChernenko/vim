import os


def findNodeUpwards(source_path: str, node: str) -> str:
    """
    Ищет нужный узел по текущей папке и всем родительским
    """
    current_dir, next_dir = source_path, os.path.dirname(source_path)
    while current_dir != next_dir:  # пока не достигнем корня
        path_to_node = os.path.join(current_dir, node)
        if os.path.exists(path_to_node):
            return path_to_node
        current_dir = next_dir  # поднимаемся на уровень выше
        next_dir = os.path.dirname(current_dir)
    return ""
