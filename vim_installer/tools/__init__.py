from typing import Optional

from .common import (
    RED_TEMPLATE,
    PackageManagers,
    PlatformSetup,
    SupportedOS,
    startPrint,
    successPrint,
)
from .common_tools import *

__platform_setup: Optional[PlatformSetup] = getPlatformSetup()
if __platform_setup is None:
    raise OSError("Unsupported OS or package manager")

if __platform_setup.os in (SupportedOS.MACOS, SupportedOS.LINUX):
    from .posix_tools import installVimPlug

    if __platform_setup.os == SupportedOS.MACOS:
        from .posix_tools import setupVimspectorMac as setupVimspector
    elif __platform_setup.os == SupportedOS.LINUX:
        from .posix_tools import setupVimspectorLinux as setupVimspector

    if __platform_setup.package_manager == PackageManagers.APT:
        from .posix_tools import installCppApt as installCpp
        from .posix_tools import installFontsApt as installFonts
        from .posix_tools import installPythonApt as installPython
        from .posix_tools import installVimFullApt as installVimFull
        from .posix_tools import installVimMinimalApt as installVimMinimal
        from .posix_tools import installYCMApt as installYCM

    elif __platform_setup.package_manager == PackageManagers.BREW:
        from .posix_tools import installCppBrew as installCpp
        from .posix_tools import installFontsBrew as installFonts
        from .posix_tools import installPythonBrew as installPython
        from .posix_tools import installVimBrew as installVimFull
        from .posix_tools import installVimBrew as installVimMinimal
        from .posix_tools import installYCMBrew as installYCM

    elif __platform_setup.package_manager == PackageManagers.DNF:
        from .posix_tools import installCppDnf as installCpp
        from .posix_tools import installFontsDnf as installFonts
        from .posix_tools import installPythonDnf as installPython
        from .posix_tools import installVimFullDnf as installVimFull
        from .posix_tools import installVimMinimalDnf as installVimMinimal
        from .posix_tools import installYCMDnf as installYCM
