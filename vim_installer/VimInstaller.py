import abc
import subprocess
from enum import IntEnum
from typing import Optional

from .tools import (
    HOME_DIR,
    RED_TEMPLATE,
    PlatformSetup,
    copyDirectory,
    copyFile,
    createDirectory,
    getPlatformSetup,
    installCpp,
    installFonts,
    installPlugins,
    installPython,
    installVimFull,
    installVimMinimal,
    installVimPlug,
    installYCM,
    runCommand,
    setupVimspector,
    setupYCMExtraConfig,
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


class VimInstallerException(Exception):
    def __init__(self, message: Optional[str] = None):
        self._message: Optional[str] = message

    def __str__(self):
        return RED_TEMPLATE.format(self._message) if self._message is not None else super().__str__()


class VimInstaller:
    def __init__(self, installation_type: InstallationTypes):
        self._platform_setup: Optional[PlatformSetup] = getPlatformSetup()
        if self._platform_setup is None:
            raise VimInstallerException("Unsupported OS or package manager")

        self._installer: Optional[InstallerBase] = None
        # in some verstions of OS there is not match/case, because of lower python versions
        if installation_type == InstallationTypes.FULL:
            self._installer = VimFullInstaller()
        elif installation_type == InstallationTypes.MINIMAL:
            self._installer = VimPosixMinimalInstaller()
        elif installation_type == InstallationTypes.SYNC_FULL:
            self._installer = VimSyncFullInstaller()
        elif installation_type == InstallationTypes.SYNC_MINIMAL:
            self._installer = VimSyncMinimalInstaller()

    def run(self):
        self._installer.run()


class InstallerBase(abc.ABC):
    @abc.abstractmethod
    def run(self):
        raise NotImplementedError


class VimFullInstaller(InstallerBase):
    def run(self):
        try:
            startPrint("installing git, curl, vim")
            installVimFull()
            installVimPlug()
            createDirectory(f"{HOME_DIR}/temp")
            # vim config
            copyFile("./data/vimrc_configs", HOME_DIR, ".vimrc")
            plug_install_result: subprocess.Popen = installPlugins()
            # fonts
            startPrint("installing fonts")
            installFonts()

            # ycm
            startPrint("installing tools for ycm")
            installYCM()
            plug_install_result.wait()
            createDirectory("/etc/apt/keyrings")

            startPrint("ycm updating submodules")
            runCommand(
                ["git", "-C", f"{HOME_DIR}/.vim/bundle/YouCompleteMe", "submodule", "update", "--init", "--recursive"],
                True,
            )
            setupYCMExtraConfig()
            # --clang-completer нужен для работы CompilationDatabase
            # подробнее: https://github.com/ycm-core/YouCompleteMe/issues/3678
            ycm_compilation_result: subprocess.Popen = subprocess.Popen(
                [
                    "python3",
                    f"{HOME_DIR}/.vim/bundle/YouCompleteMe/install.py",
                    "--clangd-completer",
                    "--clang-completer",
                ]
            )

            # js tools
            copyFile("./data/tools_configs", HOME_DIR, ".tern-config")  # for autocompletion
            # python tools
            startPrint("installing python tools")
            installPython()
            copyFile("./data/tools_configs", f"{HOME_DIR}/.config", "pycodestyle")  # autopep8
            copyFile("./data/tools_configs", HOME_DIR, ".pylintrc")
            # cpp tools
            startPrint("installing clang-formatter")
            installCpp()
            copyFile("./data/tools_configs", HOME_DIR, ".clang-format")
            # vimscpector configs
            setupVimspector()
            # running scripts
            copyDirectory("./data/scripts", f"{HOME_DIR}/.vim/scripts")
            # after loading setup
            createDirectory(f"{HOME_DIR}/.vim/after/plugin")
            copyFile("./data/vimrc_configs/plugin", f"{HOME_DIR}/.vim/after/plugin", "setup.vim", "setup.vim")

            ycm_compilation_result.wait()

            successPrint("Full installation completed")

        except subprocess.CalledProcessError as e:
            print(RED_TEMPLATE.format(f"Error executing command: {e}"))
            print(f"Return code: {e.returncode}")
            print(f"Error output: {e.stderr}")
            raise e from e


class VimPosixMinimalInstaller(InstallerBase):
    def run(self):
        try:
            startPrint("installing git, curl, vim")
            installVimMinimal()
            installVimPlug()
            createDirectory(f"{HOME_DIR}/temp")
            # vim config
            copyFile("./data/vimrc_configs", f"{HOME_DIR}", "short.vimrc", ".vimrc")
            plug_install_result: subprocess.Popen = installPlugins()
            copyDirectory("./data/scripts", f"{HOME_DIR}/.vim/scripts")

            # after loading setup
            createDirectory(f"{HOME_DIR}/.vim/after/plugin")
            copyFile("./data/vimrc_configs/plugin", f"{HOME_DIR}/.vim/after/plugin", "setup.vim", "setup.vim")

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
        setupYCMExtraConfig()
        # vimscpector configs
        setupVimspector()
        # running scripts
        copyDirectory("./data/scripts", f"{HOME_DIR}/.vim/scripts")

        # after loading setup
        createDirectory(f"{HOME_DIR}/.vim/after/plugin")
        copyFile("./data/vimrc_configs/plugin", f"{HOME_DIR}/.vim/after/plugin", "setup.vim", "setup.vim")

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

        # after loading setup
        createDirectory(f"{HOME_DIR}/.vim/after/plugin")
        copyFile("./data/vimrc_configs/plugin", f"{HOME_DIR}/.vim/after/plugin", "setup.vim", "setup.vim")

        plug_install_result.wait()

        successPrint("Minimal sync finished")
