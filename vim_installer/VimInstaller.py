import abc
import subprocess
import sys
from enum import Enum, IntEnum
from typing import Optional

from tools import (
    HOME_DIR,
    RED_TEMPLATE,
    copyDirectory,
    copyFile,
    createDirectory,
    installPlugins,
    installVimPlug,
    runCommand,
    startPrint,
    successPrint,
)


class InstallationTypes(IntEnum):
    """Every type can't be represented by others"""

    NO_ACTION = 0b0000
    FULL = 0b0001
    MINIMAL = 0b0010
    SYNC_FULL = 0b0100
    SYNC_MINIMAL = 0b1000


class PackageManagers(Enum):
    DNF = "dnf"
    APT = "apt"
    BREW = "brew"


class SupportedOS(Enum):
    """Enum class of supported OS (macOS, linux)"""

    MACOS = "darwin"
    LINUX = "linux"


class VimInstallerException(Exception):
    def __init__(self, message: Optional[str] = None):
        self._message: Optional[str] = message

    def __str__(self):
        return RED_TEMPLATE.format(self._message) if self._message is not None else super().__str__()


class VimInstaller:
    def __init__(self, installation_type: InstallationTypes):
        self._installer: Optional[InstallerBase] = None
        # in some verstions of OS there is not match/case, because of lower python versions
        if installation_type == InstallationTypes.SYNC_FULL:
            self._installer = VimSyncFullInstaller()
            return
        if installation_type == InstallationTypes.SYNC_MINIMAL:
            self._installer = VimSyncMinimalInstaller()
            return

        # other installation types are platform dependable
        try:
            os = SupportedOS(sys.platform)
        except ValueError as e:
            raise VimInstallerException("OS doesn't supported") from e

        system_manager: Optional[PackageManagers] = None
        if os == SupportedOS.MACOS:
            system_manager = PackageManagers.BREW
        else:
            for manager in PackageManagers:
                try:
                    startPrint(f"Trying to call {manager.value}")
                    runCommand([manager.value, "--version"])
                    system_manager = manager
                    break
                except subprocess.CalledProcessError:
                    print(f"{manager} not installed")
                except FileNotFoundError:
                    print(f"{manager} not installed")

            if system_manager is None:
                raise VimInstallerException("No support package manager")

        successPrint(f"found {system_manager.value} package manager")
        if installation_type == InstallationTypes.FULL:
            if system_manager == PackageManagers.DNF:
                self._installer = VimDnfFullInstaller()
                return

        if installation_type == InstallationTypes.MINIMAL:
            self._installer = VimPosixMinimalInstaller(system_manager)

    def run(self):
        self._installer.run()


class InstallerBase(abc.ABC):
    @abc.abstractmethod
    def run(self):
        raise NotImplementedError


class VimDnfFullInstaller(InstallerBase):
    def run(self):
        try:
            startPrint("installing git, curl, vim")
            runCommand(["sudo", "dnf", "install", "-y", "git", "curl", "vim", "vim-X11"], True)
            installVimPlug()
            createDirectory(f"{HOME_DIR}/temp")
            # vim config
            copyFile("./data/vimrc_configs", HOME_DIR, ".vimrc")
            plug_install_result: subprocess.Popen = installPlugins()
            # fonts
            startPrint("installing fonts")
            copyDirectory("./data/ui/fonts/JetBrainsMonoLinux", r"/usr/share/fonts/JetBrainsMono Nerd Font Mono")
            runCommand(["fc-cache", "-f", "-v"])

            # ycm
            startPrint("installing tools for ycm")
            runCommand(
                [
                    "sudo",
                    "dnf",
                    "install",
                    "-y",
                    "cmake",
                    "gcc-c++",
                    "make",
                    "python3-devel",
                    "mono-complete",
                    "golang",
                    "nodejs",
                    "java-17-openjdk",
                    "java-17-openjdk-devel",
                    "npm",
                ],
                True,
            )
            copyFile(
                "./data/tools_configs", f"{HOME_DIR}/.vim/bundle/YouCompleteMe/third_party/ycmd", ".ycm_extra_conf.py"
            )
            plug_install_result.wait()
            createDirectory("/etc/apt/keyrings")
            runCommand(
                [
                    "curl",
                    "-fsSL",
                    "https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key",
                ],
            )
            runCommand(
                [
                    "sudo",
                    "gpg",
                    "--dearmor",
                    "-o",
                    "/etc/apt/keyrings/nodesource.gpg",
                ],
                True,
            )
            runCommand(
                'echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] \
                  https://deb.nodesource.com/node_current.x nodistro main" | \
                  sudo tee /etc/apt/sources.list.d/nodesource.list',
            )
            startPrint("ycm updating submodules")
            runCommand(
                ["git", "-C", f"{HOME_DIR}/.vim/bundle/YouCompleteMe", "submodule", "update", "--init", "--recursive"],
                True,
            )
            ycm_compilation_result: subprocess.Popen = subprocess.Popen(
                ["python3", f"{HOME_DIR}/.vim/bundle/YouCompleteMe/install.py", "--clangd-completer"]
            )

            # js tools
            copyFile("./data/tools_configs", HOME_DIR, ".tern-config")  # for autocompletion
            # python tools
            startPrint("installing pip")
            runCommand(["sudo", "dnf", "install", "-y", "pip", "black", "pylint"], True)
            runCommand(["python3", "-m", "install", "pylint", "isort", "mypy", "black"])
            copyFile("./data/tools_configs", f"{HOME_DIR}/.config", "pycodestyle")  # autopep8
            copyFile("./data/tools_configs", HOME_DIR, ".pylintrc")
            # cpp tools
            startPrint("installing clang-formatter")
            runCommand(["sudo", "dnf", "install", "-y", "clang-tools-extra"], True)
            copyFile("./data/tools_configs", HOME_DIR, ".clang-format")
            # running scripts
            copyDirectory("./data/scripts", f"{HOME_DIR}/.vim/scripts")

            ycm_compilation_result.wait()

            successPrint("Full installation completed")

        except subprocess.CalledProcessError as e:
            print(RED_TEMPLATE.format(f"Error executing command: {e}"))
            print(f"Return code: {e.returncode}")
            print(f"Error output: {e.stderr}")
            raise e from e


class VimPosixMinimalInstaller(InstallerBase):
    def __init__(self, package_manager: PackageManagers):
        self._package_manager: PackageManagers = package_manager

    def run(self):
        try:
            startPrint("installing git, curl, vim")
            if self._package_manager == PackageManagers.BREW:
                runCommand(
                    [
                        self._package_manager.value,
                        "install",
                        "git",
                        "curl",
                        "vim",
                    ],
                    True,
                )
            else:
                runCommand(
                    [
                        "sudo",
                        self._package_manager.value,
                        "install",
                        "-y",
                        "git",
                        "curl",
                        "vim",
                    ],
                    True,
                )
            installVimPlug()
            createDirectory(f"{HOME_DIR}/temp")
            # vim config
            copyFile("./data/vimrc_configs", f"{HOME_DIR}", "short.vimrc", ".vimrc")
            plug_install_result: subprocess.Popen = installPlugins()
            copyDirectory("./data/scripts", f"{HOME_DIR}/.vim/scripts")
            plug_install_result.wait()
            successPrint("Minimal installation completed")

        except subprocess.CalledProcessError as e:
            print(RED_TEMPLATE.format(f"Error executing command: {e}"))
            print(f"Return code: {e.returncode}")
            print(f"Error output: {e.stderr}")
            raise e from e


class VimSyncFullInstaller(InstallerBase):
    def run(self):
        startPrint("Running full sync")
        createDirectory(f"{HOME_DIR}/temp")
        # vim config
        copyFile("./data/vimrc_configs", HOME_DIR, ".vimrc")
        plug_install_result: subprocess.Popen = installPlugins()
        # js tools
        copyFile("./data/tools_configs", HOME_DIR, ".tern-config")  # for autocompletion
        # python tools
        copyFile("./data/tools_configs", f"{HOME_DIR}/.config", "pycodestyle")  # autopep8
        copyFile("./data/tools_configs", HOME_DIR, ".pylintrc")
        # cpp tools
        copyFile("./data/tools_configs", HOME_DIR, ".clang-format")
        # ycm extra conf
        copyFile("./data/tools_configs", f"{HOME_DIR}/.vim/bundle/YouCompleteMe/third_party/ycmd", ".ycm_extra_conf.py")
        # running scripts
        copyDirectory("./data/scripts", f"{HOME_DIR}/.vim/scripts")
        plug_install_result.wait()
        successPrint("Full sync finished")


class VimSyncMinimalInstaller(InstallerBase):
    def run(self):
        startPrint("Running minimal sync")
        createDirectory(f"{HOME_DIR}/temp")
        # vim config
        copyFile("./data/vimrc_configs", f"{HOME_DIR}", "short.vimrc", ".vimrc")
        plug_install_result: subprocess.Popen = installPlugins()
        # running scripts
        copyDirectory("./data/scripts", f"{HOME_DIR}/.vim/scripts")
        plug_install_result.wait()
        successPrint("Minimal sync finished")
