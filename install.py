import enum
import sys
import os


HOME_DIR = os.path.expanduser('~')
PACKAGE_MANAGER = input("Enter: your package manager: ")
PLATFORM = sys.platform
INSTALLATION_TYPE = int(input("choose installation:\n1. quick\n2. full\n"))

SUCCESS_MESSAGE = "\033[32m_______________{} installed successfully_______________\n\033[0m"
ERROR_MESSAGE = "\033[31m{} failed\033[0m"


class InstalltionType(enum.IntEnum):
    QUICK = 1
    FULL  = 2


def createDirectory(path: str):
    """Creates dir if it doesn't exist, else nothing"""
    if not os.path.exists(path):
        os.makedirs(path)


def installVim():
    global PACKAGE_MANAGER
    vim_curl_dict = {"apt": "sudo apt install -y vim curl vim-gtk3",
                     "dnf": "sudo dnf install -y vim curl",
                     "brew": "sudo brew install -y vim curl"}
    print("installing vim")

    if os.system(vim_curl_dict[PACKAGE_MANAGER]) != 0:
        raise OSError(ERROR_MESSAGE.format("vim and curl installation"))

    print("installing vim-plug")
    if os.system("""curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim""") != 0:
        raise OSError(ERROR_MESSAGE.format("vim-plug installation"))
    print(SUCCESS_MESSAGE.format("vim and curl"))


def setupVimrc():
    global HOME_DIR
    print("setup config for .vimrc")

    if os.path.exists(f"{HOME_DIR}/.vimrc"):
        createDirectory(f"{HOME_DIR}/temp")
        print("dump current .vimrc")
        os.system("cp ~/.vimrc ~/temp/.vimrc")

    if os.system("cp ./configs/.vimrc ~/.vimrc") != 0:
        raise OSError(ERROR_MESSAGE.format("copying .vimrc"))
    print(SUCCESS_MESSAGE.format(".vimrc"))


def installMonokai():
    global HOME_DIR
    print("installing monokai colorsheme")
    createDirectory(f"{HOME_DIR}/.vim/colors")
    if os.system("cp ./ui/monokai_custom.vim ~/.vim/colors/monokai_custom.vim") == 0:
        print(SUCCESS_MESSAGE.format("monokai colorsheme"))

    fonts_dir_dict = {"apt": "/usr/share/fonts/truetype/JetBrainsMono",
                      "dnf": "/usr/share/fonts/JetBrainsMono"}
    print("installing fonts")
    os.system(f"sudo mkdir {fonts_dir_dict[PACKAGE_MANAGER]}")
    os.system(f"sudo cp -r ./ui/fonts/JetBrainsMono/fonts/ttf/* {fonts_dir_dict[PACKAGE_MANAGER]}")
    os.system("fc-cache -f -v")


def setupPylint():
    global HOME_DIR, PACKAGE_MANAGER
    pylint_dict = {"apt": "sudo apt install pylint",
                   "dnf": "sudo dnf install pylint"}
    print("installing pylint")
    os.system("python3 -m pip install pylint")
    os.system(pylint_dict[PACKAGE_MANAGER])

    if not os.path.exists(f"{HOME_DIR}/.pylintrc"):
        os.system("pylint --generate-rcfile > ~/.pylintrc")
    else:
        print("dump current .pylintrc")
        os.system("cp ~/.pylintrc ~/temp/.pylintrc")

    if os.system("cp ./configs/.pylintrc ~/.pylintrc") != 0:
        raise OSError(ERROR_MESSAGE.format("copying .pylintrc"))
    print(SUCCESS_MESSAGE.format(".pylintrc"))


def installYouCompleteMe():
    global PACKAGE_MANAGER
    ycm_dict = {"apt": """sudo apt install -y build-essential cmake vim-nox python3-dev \
                mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm""",
                "dnf": """sudo dnf install -y cmake gcc-c++ make python3-devel \
                mono-complete golang nodejs java-17-openjdk java-17-openjdk-devel npm""",
                "brew": """sudo brew install cmake python go nodejs mono java"""}

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
    print(SUCCESS_MESSAGE.format("ycm"))


installVim()
setupVimrc()
if INSTALLATION_TYPE == InstalltionType.FULL.value:
    installMonokai()
    setupPylint()
    #installYouCompleteMe()
