from os.path import expanduser
from typing import Final, Optional

HOME_DIR = expanduser("~")
GREEN_TEMPLATE = "\033[32m{:_^70}\n\033[0m"
YELLOW_TEMPLATE: Final[str] = "\033[33m{}\033[0m"
RED_TEMPLATE: Final[str] = "\033[31m{}\033[0m"


def successPrint(message):
    print(GREEN_TEMPLATE.format(message))


def startPrint(message):
    print(YELLOW_TEMPLATE.format(message))
