from os.path import expanduser
from typing import Final

HOME_DIR = expanduser("~")
GREEN_TEMPLATE = "\033[32m{:_^60}\n\033[0m"
YELLOW_TEMPLATE: Final[str] = "\033[33m{}\033[0m"
RED_TEMPLATE: Final[str] = "\033[31m{}\033[0m"


class VimInstallerException(Exception):
    message = "VimInstallerException"

    def __str__(self):
        return RED_TEMPLATE.format(self.message)


def successPrint(message):
    print(GREEN_TEMPLATE.format(message))
