from enum import Enum
from os.path import expanduser


HOME_DIR = expanduser('~')


def successPrint(message):
    green_template = "\033[32m{:_^60}\n\033[0m"
    print(green_template.format(message))


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
