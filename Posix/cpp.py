import os

from exceptions import CppToolsInstallationFailed
from GlobalVars import HOME_DIR, PackageManagers, successPrint

from Posix.posixTools import copyFile


def installCppTools(package_manager: PackageManagers):
    print("installing cpp tools")
    clang_format_dict = {PackageManagers.APT: "sudo apt install -y clang-tools-extra",
                         PackageManagers.DNF: "sudo dnf install -y clang-tools-extra"}
    if os.system(clang_format_dict[package_manager]) != 0:
        raise CppToolsInstallationFailed
    successPrint("cpp tools installed")


def setupClangFormat():
    print("setup clang-format")
    copyFile("./configs", HOME_DIR, ".clang-format")
    successPrint("clang format setup completed")
