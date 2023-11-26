import enum
import os
from sys import platform


HOME_DIR = os.path.expanduser('~')
SUCCESS_MESSAGE = "\033[32m{:_^60}\n\033[0m"
ERROR_MESSAGE = "\033[31m{} failed\033[0m"


class InstallationType(enum.IntEnum):
    UPDATE_VIMRC = 1
    QUICK = 2
    FULL  = 3


def createDirectory(path: str):
    """Creates dir if it doesn't exist, else nothing"""
    if not os.path.exists(path):
        os.makedirs(path)


def installVim():
    vim_curl_dict = {"apt": "sudo apt install -y vim curl vim-gtk3",
                     "dnf": "sudo dnf install -y vim curl vim-X11",
                     "brew": "brew install vim curl"}
    print("installing vim")

    if os.system(vim_curl_dict[PACKAGE_MANAGER]) != 0:
        raise OSError(ERROR_MESSAGE.format("vim and curl installation completed"))

    print("installing vim-plug")
    if os.system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim") != 0:
        raise OSError(ERROR_MESSAGE.format("vim-plug installation"))
    print(SUCCESS_MESSAGE.format("vim-plug installed"))


def setupVimrc():
    print("setup config for .vimrc")

    if os.path.exists(f"{HOME_DIR}/.vimrc"):
        createDirectory(f"{HOME_DIR}/temp")
        print("dump current .vimrc")
        os.system("cp ~/.vimrc ~/temp/.vimrc")

    if os.system("cp ./configs/.vimrc ~/.vimrc") != 0:
        raise OSError(ERROR_MESSAGE.format("copying .vimrc"))
    print(SUCCESS_MESSAGE.format(".vimrc setup completed"))

    while not os.path.exists(f"{HOME_DIR}/.vim/bundle"):
        print("run vim and type \":PlugInstall\", then enter anything")
        input()


def installMonokai():
    print("installing monokai colorsheme")
    createDirectory(f"{HOME_DIR}/.vim/colors")
    if os.system("cp ./ui/monokai_custom.vim ~/.vim/colors/monokai_custom.vim") == 0:
        print(SUCCESS_MESSAGE.format("monokai colorsheme installed"))

    print("installing fonts")
    fonts_dir_dict = {"apt": "/usr/share/fonts/truetype/JetBrainsMono",
                      "dnf": "/usr/share/fonts/JetBrainsMono"}

    os.system(f"sudo mkdir {fonts_dir_dict[PACKAGE_MANAGER]}")
    if os.system(f"sudo cp ./ui/fonts/JetBrainsMono/fonts/ttf/* {fonts_dir_dict[PACKAGE_MANAGER]}") != 0:
        raise OSError(ERROR_MESSAGE.format("copying fonts"))
    os.system("fc-cache -f -v")
    print(SUCCESS_MESSAGE.format("fonts installed"))


def installPip():
    print("installing pip")
    pip_dict = {"apt": "sudo apt install pip",
                   "dnf": "sudo dnf install pip"}
    if PACKAGE_MANAGER in pip_dict:
        if os.system(pip_dict[PACKAGE_MANAGER]) != 0:
            raise OSError(ERROR_MESSAGE.format("installing pip"))

    #if platform == "linux":
        #os.system("sudo chown -R $USER:$USER /etc/zshenv")
        #os.system(f"echo \"path+=({HOME_DIR}/.local/bin)\" >> /etc/zshenv")


def setupPylint():
    print("installing pylint")
    if os.system("python3 -m pip install pylint") != 0:
        raise OSError(ERROR_MESSAGE.format("installing pylint"))

    if not os.path.exists(f"{HOME_DIR}/.pylintrc"):
        os.system("pylint --generate-rcfile > ~/.pylintrc")
    else:
        print("dump current .pylintrc")
        os.system("cp ~/.pylintrc ~/temp/.pylintrc")

    if os.system("cp ./configs/.pylintrc ~/.pylintrc") != 0:
        print(ERROR_MESSAGE.format("pylint generate"))
        print(f"Probably you need to add {HOME_DIR}/.local/bin to the PATH")
        choice = int(input("type 1 to add to .zshenv\ntype 2 to add to .bashrc:"))
    print(SUCCESS_MESSAGE.format(".pylintrc setup completed"))


def installYouCompleteMe():
    ycm_dict = {"apt": "sudo apt install -y build-essential cmake vim-nox python3-dev \
                mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm",
                "dnf": "sudo dnf install -y cmake gcc-c++ make python3-devel \
                mono-complete golang nodejs java-17-openjdk java-17-openjdk-devel npm",
                "brew": "brew install cmake python go nodejs mono java"}

    print("installing YCM")

    os.system(ycm_dict[PACKAGE_MANAGER])
    os.system("sudo mkdir -p /etc/apt/keyrings")

    os.system("curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
                  sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg")

    os.system('echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] \
                  https://deb.nodesource.com/node_current.x nodistro main" | \
                  sudo tee /etc/apt/sources.list.d/nodesource.list')

    os.system(f"git -C {HOME_DIR}/.vim/bundle/YouCompleteMe submodule update --init --recursive")

    if os.system("python3 ~/.vim/bundle/YouCompleteMe/install.py --clangd-completer") != 0:
        raise OSError(ERROR_MESSAGE.format("installation ycm"))
    print(SUCCESS_MESSAGE.format("ycm installed"))



def setupVimspector():
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
        raise OSError(ERROR_MESSAGE.format("setup vimspector"))
    print(SUCCESS_MESSAGE.format("vimspector setup completed"))


if __name__ == "__main__":
    PACKAGE_MANAGER = input("Enter: your package manager: ")
    INSTALLATION_TYPE = int(input("choose installation:\n1. update vimrc\n2. quick\n3. full\n"))

    if INSTALLATION_TYPE == InstallationType.UPDATE_VIMRC:
        setupVimrc()
    else:
        installVim()
        setupVimrc()
        if INSTALLATION_TYPE == InstallationType.FULL:
            installMonokai()
            installPip()
            setupPylint()
            installYouCompleteMe()
            setupVimspector()
