from GlobalVars import InstallationTypes, PackageManagers

from Posix.posixTools import *


def updateVim() -> None:
    """Updates .vimrc, .pylintrc and .ycm_extra_conf.py"""
    setupVimrc()
    setupPylintrc()
    setupYCMExtraConf()


def posixQuickInstall(package_manager: PackageManagers) -> None:
    """Makes fast install with short .vimrc"""
    installVim(package_manager)
    setupVimrc(full=False)


def posixFullInstall(package_manager: PackageManagers) -> None:
    """Makes full install"""
    installVim(package_manager)
    setupVimrc()
    installMonokai(package_manager)
    installPip(package_manager)
    setupPylint()
    installYouCompleteMe(package_manager)
    setupVimspector()


def posix(installation_type: InstallationTypes) -> None:
    """Supervisor function that makes installation for
    posix systems"""
    if installation_type == InstallationTypes.UPDATE_VIMRC:
        updateVim()
        return

    package_manager = PackageManagers(input("Enter your package manager: "))
    if installation_type == InstallationTypes.QUICK:
        posixQuickInstall(package_manager)
        return

    if installation_type == InstallationTypes.FULL:
        posixFullInstall(package_manager)
        return
