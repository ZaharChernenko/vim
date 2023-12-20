from enum import Enum
from os.path import expanduser
from sys import platform


HOME_DIR = expanduser('~')
SUCCESS_MESSAGE = "\033[32m{:_^60}\n\033[0m"
ERROR_MESSAGE = "\033[31m{}\033[0m"


class SupportedOS(Enum):
    """Enum class of supported OS (macOS, linux)"""
    MACOS = "darwin"
    LINUX = "linux"


class InstallationTypes(Enum):
    UPDATE_VIMRC = "1"
    QUICK = "2"
    FULL = "3"


class PackageManagers(Enum):
    DNF = "dnf"
    APT = "apt"
    BREW = "brew"


def getOS() -> SupportedOS:
    try:
        os = SupportedOS(platform)
    except ValueError:
        raise OSError(ERROR_MESSAGE.format("Sorry you OS is not supported"))
    return os
