import enum
import sys
import os


HOME_DIR = os.path.expanduser('~')
PACKAGE_MANAGER = input("Enter: your package manager: ")
PLATFORM = sys.platform
INSTALLATION_TYPE = int(input("choose installation:\n1. quick\n2. full\n"))


class InstalltionType(enum.IntEnum):
    QUICK = 1
    FULL  = 2


def checkDirectory(path):
    if not os.path.exists(path):
        os.makedirs(path)


def installVim():
    global PACKAGE_MANAGER
    os.system("echo installing vim")
    if os.system(f"sudo {PACKAGE_MANAGER} install -y vim") == 0:
        os.system("echo installing vim-plug")
        os.system("""curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim""")
        os.system("echo success")
        os.system("echo")
    else:
        raise OSError("can't install vim")


def setupVimrc():
    global HOME_DIR
    os.system("echo setup config for .vimrc")

    if os.path.exists(f"{HOME_DIR}/.vimrc"):
        checkDirectory(f"{HOME_DIR}/temp")
        os.system("echo dump current .vimrc")
        os.system("cp ~/.vimrc ~/temp/.vimrc")

    if os.system("cp ./configs/.vimrc ~/.vimrc") == 0:
        os.system("echo success")
        os.system("echo")


def installMonokai():
    global HOME_DIR
    os.system("echo installing monokai colorsheme")
    checkDirectory(f"{HOME_DIR}/.vim/colors")
    if os.system("cp ./ui/monokai_custom.vim ~/.vim/colors/monokai_custom.vim") == 0:
        os.system("echo monokai installed successfully")
        os.system("echo")


def setupPylint():
    global HOME_DIR
    os.system("echo installing pylint")
    os.system("python3 -m pip install pylint")
    if not os.path.exists(f"{HOME_DIR}/.pylintrc"):
        os.system("pylint --generate-rcfile > ~/.pylintrc")
    else:
        os.system("echo dump current .pylintrc")
        os.system("cp ~/.pylintrc ~/temp/.pylintrc")
    if os.system("cp ./configs/.pylintrc ~/.pylintrc") == 0:
        os.system("echo success")
        os.system("echo")


def installYouCompleteMe():
    os.system("echo installing YCM")
    if PLATFORM == "linux":
        os.system(f"sudo {PACKAGE_MANAGER} install -y build-essential cmake vim-nox python3-dev")
        os.system("sudo mkdir -p /etc/apt/keyrings")

        os.system("curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | \
                  sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg")

        os.system('echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] \
                  https://deb.nodesource.com/node_current.x nodistro main" | \
                  sudo tee /etc/apt/sources.list.d/nodesource.list')

        os.system("sudo apt install -y mono-complete golang nodejs openjdk-17-jdk openjdk-17-jre npm")
        if os.system("python3 ~/.vim/bundle/YouCompleteMe/install.py - all") == 0:
            os.system("echo success")
            os.system("echo")


installVim()
setupVimrc()
if INSTALLATION_TYPE == InstalltionType.FULL.value:
    installMonokai()
    setupPylint()
    installYouCompleteMe()
