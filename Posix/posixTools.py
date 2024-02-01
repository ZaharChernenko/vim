import os
from sys import platform

from exceptions import *
from GlobalVars import HOME_DIR, PackageManagers, successPrint


def createDirectory(path: str):
    """Creates dir if it doesn't exist, else nothing"""
    if not os.path.exists(path):
        os.makedirs(path)


def installVim(package_manager: PackageManagers):
    print("installing vim")
    vim_curl_dict = {PackageManagers.APT: "sudo apt install -y vim curl vim-gtk3",
                     PackageManagers.DNF: "sudo dnf install -y vim curl vim-X11",
                     PackageManagers.BREW: "brew install vim curl"}

    if os.system(vim_curl_dict[package_manager]) != 0:
        raise VimInstallationFailed

    print("installing vim-plug")
    if os.system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim") != 0:
        raise VimPlugInstallationFailed
    successPrint("vim-plug installed")


def setupVimrc(full: bool = True):
    print("setup config for .vimrc")

    if os.path.exists(f"{HOME_DIR}/.vimrc"):
        createDirectory(f"{HOME_DIR}/temp")
        print("dump current .vimrc")
        os.system("cp ~/.vimrc ~/temp/.vimrc")

    if full:
        if os.system("cp ./configs/.vimrc ~/.vimrc") != 0:
            raise CopyingVimrcFailed
        successPrint(".vimrc setup completed")

    else:
        if os.system("cp ./configs/short.vimrc ~/.vimrc") != 0:
            raise CopyingVimrcFailed
        successPrint(".vimrc setup completed")

    while not os.path.exists(f"{HOME_DIR}/.vim/bundle"):
        print("run vim and type \":PlugInstall\", then enter anything")
        input()


def copyThemes():
    print("copying themes")
    createDirectory(f"{HOME_DIR}/.vim/colors")
    if os.system("cp ./ui/*.vim ~/.vim/colors/") == 0:
        successPrint("copied successfully")


def setupUI(package_manager: PackageManagers):
    copyThemes()

    print("installing fonts")
    fonts_dir_dict = {PackageManagers.APT: r"/usr/share/fonts/truetype/JetBrainsMono\ Nerd\ Font\ Mono",
                      PackageManagers.DNF: r"/usr/share/fonts/JetBrainsMono\ Nerd\ Font\ Mono"}

    os.system(f"sudo mkdir {fonts_dir_dict[package_manager]}")
    if os.system(f"sudo cp ./ui/fonts/JetBrainsMonoLinux/* {fonts_dir_dict[package_manager]}") != 0:
        raise FontsInstallationFailed
    os.system("fc-cache -f -v")
    successPrint("fonts installed")


def installPip(package_manager: PackageManagers):
    print("installing pip")
    pip_dict = {PackageManagers.APT: "sudo apt install -y pip",
                PackageManagers.DNF: "sudo dnf install -y pip"}

    if package_manager in pip_dict:
        if os.system(pip_dict[package_manager]) != 0:
            raise PipInstallationFailed
    successPrint("pip installed")


def setupPylintrc():
    if os.system("cp ./configs/.pylintrc ~/.pylintrc") != 0:
        raise CopyingPylintcFailed
    successPrint(".pylintrc setup completed")


def setupLinters():
    print("installing linters")
    if os.system("python3 -m pip install pylint autopep8 isort mypy") != 0:
        raise LintersInstallationFailed
    os.system("source $HOME/.profile")
    successPrint("linters installed successfully")

    if not os.path.exists(f"{HOME_DIR}/.pylintrc"):
        if os.system("pylint --generate-rcfile > ~/.pylintrc") != 0:
            print(
                f"Probably you need to add {HOME_DIR}/.local/bin to the PATH")
            raise PylintSetupFailed
    else:
        print("dump current .pylintrc")
        os.system("cp ~/.pylintrc ~/temp/.pylintrc")
    setupPylintrc()


def setupAutopep():
    print("setup pycodestyle")
    if os.system("cp ./configs/pycodestyle ~/.config/") != 0:
        raise CopyingAutopepFailed
    successPrint("autopep setup completed")


def setupYCMExtraConf():
    if os.system("cp ./configs/.ycm_extra_conf.py ~/.vim/bundle/YouCompleteMe/third_party/ycmd/") != 0:
        raise CopyingYCMConfFailed


def installYouCompleteMe(package_manager: PackageManagers):
    print("installing YCM")
    ycm_dict = {PackageManagers.APT: "sudo apt install -y build-essential cmake vim-nox \
                python3-dev mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm",
                PackageManagers.DNF: "sudo dnf install -y cmake gcc-c++ make python3-devel \
                mono-complete golang nodejs java-17-openjdk java-17-openjdk-devel npm",
                PackageManagers.BREW: "brew install cmake python go nodejs mono java"}

    os.system(ycm_dict[package_manager])
    os.system("sudo mkdir -p /etc/apt/keyrings")

    os.system("curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
                  sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg")

    os.system('echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] \
                  https://deb.nodesource.com/node_current.x nodistro main" | \
                  sudo tee /etc/apt/sources.list.d/nodesource.list')

    os.system(
        "git -C ~/.vim/bundle/YouCompleteMe submodule update --init --recursive")

    if os.system("python3 ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer") != 0:
        raise YCMInstallationFailed
    setupYCMExtraConf()
    successPrint("ycm installed")


def setupVimspector():
    print("setup vimspector")
    path_to_vimspector = f"{HOME_DIR}/.vim/bundle/vimspector/configurations/{{}}/"
    if platform == "darwin":
        path_to_vimspector = path_to_vimspector.format("macos")
    else:
        path_to_vimspector = path_to_vimspector.format("linux")

    if os.path.exists(path_to_vimspector):
        print("dump current configs")
        os.system(f"cp -r {path_to_vimspector}/* {HOME_DIR}/temp")
    else:
        createDirectory(path_to_vimspector)

    if os.system(f"cp -r ./vimspector_configs/* {path_to_vimspector}") != 0:
        raise VimspectorSetupFailed
    successPrint("vimspector setup completed")
