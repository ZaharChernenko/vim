import typing

import completers


class TCompleterContext:
    LANG_TO_COMPLETER: typing.Final[typing.Dict[str, typing.Type[completers.ICompleter]]] = {
        "python": completers.TPythonCompleter,
        "cfamily": completers.TClangCompleter,
    }

    @classmethod
    def complete(cls, **kwargs):
        completer: typing.Optional[typing.Type[completers.ICompleter]] = cls.LANG_TO_COMPLETER.get(
            kwargs["language"], None
        )
        return completer.complete(**kwargs) if completer is not None else None
