from GlobalVars import InstallationTypes, PackageManagers

from Posix.cpp import installCppTools
from Posix.formatters_linters import setupFormattersLinters
from Posix.posixTools import *
from Posix.python import installPip, installPythonTools


def updateVim() -> None:
    """Updates .vimrc, .pylintrc and .ycm_extra_conf.py"""
    setupVimrc()
    copyThemes()
    setupJS()
    setupFormattersLinters()
    setupYCMExtraConf()
    copyScripts()


def posixQuickInstall(package_manager: PackageManagers) -> None:
    """Makes fast install with short .vimrc"""
    installVim(package_manager)
    setupVimrc(full=False)
    copyScripts()


def posixFullInstall(package_manager: PackageManagers) -> None:
    """Makes full install"""
    installVim(package_manager)
    setupVimrc()
    setupUI(package_manager)
    # python
    installPip(package_manager)
    installPythonTools()
    installCppTools(package_manager)
    # cpp
    setupJS()
    setupFormattersLinters()
    installYouCompleteMe(package_manager)
    setupVimspector()
    copyScripts()


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
