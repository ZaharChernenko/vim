from enum import Enum


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
