import abc


class ICompleter(abc.ABC):
    """Abstract base class for completers."""

    @classmethod
    @abc.abstractmethod
    def complete(cls, **kwargs) -> dict:
        raise NotImplementedError()
