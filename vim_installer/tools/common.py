import os
import sys
from enum import Enum
from pwd import getpwnam
from typing import Final, NamedTuple, Optional


class SupportedOS(Enum):
    """Enum class of supported OS"""

    MACOS = "darwin"
    LINUX = "linux"


class PackageManagers(Enum):
    APT = "apt"
    BREW = "brew"
    DNF = "dnf"


class PlatformSetup(NamedTuple):
    os: SupportedOS
    package_manager: Optional[PackageManagers]


# in linux script must be runned from superuser
if sys.platform == "linux":
    USERNAME: Final[str] = os.environ.get("SUDO_USER") or os.getlogin()
    HOME_DIR: Final[str] = getpwnam(USERNAME).pw_dir
elif sys.platform == "darwin":
    USERNAME: Final[str] = os.environ.get("SUDO_USER") or os.getlogin()
    HOME_DIR: Final[str] = os.path.expanduser("~")

GREEN_TEMPLATE: Final[str] = "\033[32m{:_^70}\n\033[0m"
YELLOW_TEMPLATE: Final[str] = "\033[33m{}\033[0m"
RED_TEMPLATE: Final[str] = "\033[31m{}\033[0m"


def successPrint(message):
    print(GREEN_TEMPLATE.format(message))


def startPrint(message):
    print(YELLOW_TEMPLATE.format(message))
