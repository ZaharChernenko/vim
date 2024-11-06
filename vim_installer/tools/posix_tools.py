from .common import HOME_DIR
from .common_tools import runCommand


def installVimPlug():
    runCommand(
        [
            "curl",
            "-fLo",
            f"{HOME_DIR}/.vim/autoload/plug.vim",
            "--create-dirs",
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
        ],
        "installing vim-plug",
    )
