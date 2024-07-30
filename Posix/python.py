import os

from exceptions import PipInstallationFailed, PythonToolsInstallationFailed
from GlobalVars import HOME_DIR, PackageManagers, successPrint

from Posix.posixTools import copyFile


def installPip(package_manager: PackageManagers):
    print("installing pip")
    pip_dict = {
        PackageManagers.APT: "sudo apt install -y pip",
        PackageManagers.DNF: "sudo dnf install -y pip",
    }

    if os.system(pip_dict[package_manager]) != 0:
        raise PipInstallationFailed
    successPrint("pip installed")


def installPythonTools():
    print("install python tools")
    if os.system("python3 -m pip install pylint black isort mypy") != 0:
        raise PythonToolsInstallationFailed
    os.system("source $HOME/.profile")
    successPrint("python tools installed")


def setupAutopep():
    print("setup pycodestyle")
    copyFile("./configs", f"{HOME_DIR}/.config", "pycodestyle")
    successPrint("autopep setup completed")


def setupPylintrc():
    print("setup pylintrc")
    copyFile("./configs", HOME_DIR, ".pylintrc")
    successPrint(".pylintrc setup completed")
