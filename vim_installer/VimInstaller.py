import abc
from enum import IntEnum

from tools import HOME_DIR, copyDirectory, copyFile, runCommand, startPrint


class InstallationTypes(IntEnum):
    """Every type can't be represented by others"""

    NO_ACTION = 0b0000
    FULL = 0b0001
    MINIMAL = 0b0010
    SYNC_FULL = 0b0100
    SYNC_MINIMAL = 0b1000


class VimInstaller:
    def __init__(self, installation_type: InstallationTypes):
        self.installer: InstallerBase
        if installation_type == InstallationTypes.FULL:
            self.installer = None
        elif installation_type == InstallationTypes.SYNC_FULL:
            self.installer = VimSyncFulllInstaller()
        elif installation_type == InstallationTypes.SYNC_MINIMAL:
            self.installer = VimSyncMinimalInstaller()

    def __call__(self):
        self.installer.run()


class InstallerBase(abc.ABC):
    @abc.abstractmethod
    def run(self):
        raise NotImplementedError


class VimSyncFulllInstaller(InstallerBase):
    def run(self):
        startPrint("Running full sync")
        copyFile("./data/vimrc_configs", HOME_DIR, ".vimrc")
        # js tools
        copyFile("./data/tools_configs", HOME_DIR, ".tern-config")  # for autocompletion
        # python tools
        copyFile("./data/tools_configs", f"{HOME_DIR}/.config", "pycodestyle")  # autopep8
        copyFile("./data/tools_configs", HOME_DIR, ".pylintrc")
        # cpp tools
        copyFile("./data/tools_configs", HOME_DIR, ".clang-format")
        # ycm extra conf
        copyFile(
            "./data/tools_configs", f"{HOME_DIR}/.vim/bundle/YouCompleteMe/third_party/ycmd/", ".ycm_extra_conf.py"
        )
        # running scripts
        copyDirectory("./data/scripts", f"{HOME_DIR}/.vim/scripts")


class VimSyncMinimalInstaller(InstallerBase):
    def run(self):
        startPrint("Running minimal sync")
        copyFile("./data/vimrc_configs", f"{HOME_DIR}", "short.vimrc", ".vimrc")
        copyDirectory("./data/scripts", f"{HOME_DIR}/.vim/scripts")
