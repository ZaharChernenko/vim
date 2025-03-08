import os

from .common import HOME_DIR
from .common_tools import copyDirectory, copyFile, runCommand


def installVimPlug():
    runCommand(
        [
            "curl",
            "-fLo",
            f"{HOME_DIR}/.vim/autoload/plug.vim",
            "--create-dirs",
            "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim",
        ]
    )


def installVimFullApt():
    runCommand(["sudo", "apt", "install", "-y", "git", "curl", "vim", "vim-gtk3"], True)


def installVimMinimalApt():
    runCommand(["sudo", "apt", "install", "-y", "git", "curl", "vim", "vim-gtk3"], True)


def installVimBrew():
    runCommand(["brew", "install", "git", "vim", "curl"])


def installVimFullDnf():
    runCommand(["sudo", "dnf", "install", "-y", "git", "curl", "vim", "vim-X11"], True)


def installVimMinimalDnf():
    runCommand(["sudo", "dnf", "install", "-y", "git", "curl", "vim"], True)


def installYCMApt():
    runCommand(
        [
            "sudo",
            "apt",
            "install",
            "-y",
            "build-essential",
            "cmake",
            "vim-nox",
            "python3-dev",
            "mono-complete",
            "golang",
            "nodejs",
            "openjdk-17-jdk",
            "openjdk-17-jre",
            "npm",
        ],
        True,
    )


def installYCMBrew():
    runCommand(
        [
            "brew",
            "install",
            "python",
            "mono",
            "cmake",
            "go",
            "nodejs",
            "java",
        ],
        True,
    )


def installYCMDnf():
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


def setupYCMExtraConfig():
    ycm_path: str = "./data/tools_configs/ycm_config"
    copyFile(
        source_path=ycm_path,
        target_path=f"{HOME_DIR}/.vim/bundle/YouCompleteMe/third_party/ycmd",
        source_filename=".ycm_extra_conf.py",
    )
    copyFile(
        source_path=ycm_path,
        target_path=f"{HOME_DIR}/.vim/bundle/YouCompleteMe/third_party/ycmd",
        source_filename="common.py",
    )
    copyFile(
        source_path=ycm_path,
        target_path=f"{HOME_DIR}/.vim/bundle/YouCompleteMe/third_party/ycmd",
        source_filename="cpp.py",
    )


def installPythonApt():
    runCommand(["sudo", "apt", "install", "-y", "pip", "black", "pylint"], True)
    runCommand(["python3", "-m", "pip", "install", "pylint", "isort", "mypy", "black"])


def installPythonDnf():
    runCommand(["sudo", "dnf", "install", "-y", "pip", "black", "pylint"], True)
    runCommand(["python3", "-m", "pip", "install", "pylint", "isort", "mypy", "black"])


def installPythonBrew():
    # 3.12 because macos has old python version
    runCommand(["brew", "install", "python@3.12"], True)
    runCommand(["python3.12", "-m", "pip", "install", "pylint", "isort", "mypy", "black"])


def installCppApt():
    runCommand(["sudo", "apt", "install", "-y", "clang-tools-extra", "cppcheck"], True)


def installCppBrew():
    runCommand(["sudo", "dnf", "install", "-y", "clang-format", "cppcheck"], True)


def installCppDnf():
    runCommand(["sudo", "dnf", "install", "-y", "clang-tools-extra", "cppcheck"], True)


def installFontsApt():
    os.system("sudo mkdir '/usr/share/fonts/truetype/JetBrainsMono Nerd Font Mono'")
    os.system("sudo cp ./data/ui/fonts/JetBrainsMonoLinux/* '/usr/share/fonts/truetype/JetBrainsMono Nerd Font Mono'")
    runCommand(["fc-cache", "-f", "-v"])


def installFontsBrew():
    pass


def installFontsDnf():
    os.system("sudo mkdir '/usr/share/fonts/JetBrainsMono Nerd Font Mono'")
    os.system("sudo cp ./data/ui/fonts/JetBrainsMonoLinux/* '/usr/share/fonts/JetBrainsMono Nerd Font Mono'")
    runCommand(["fc-cache", "-f", "-v"])


def setupVimspectorMac():
    copyDirectory("./data/tools_configs/vimspector_configs", f"{HOME_DIR}/.vim/bundle/vimspector/configurations/macos")


def setupVimspectorLinux():
    copyDirectory("./data/tools_configs/vimspector_configs", f"{HOME_DIR}/.vim/bundle/vimspector/configurations/linux")
