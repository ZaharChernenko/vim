import sys
from GlobalVars import InstallationTypes, SupportedOS

from Posix.posixInstaller import posix


if __name__ == "__main__":
    try:
        os = SupportedOS(sys.platform)
    except ValueError:
        print("Sorry, your os is not supported yet :(\n")
        sys.exit()

    try:
        installation_type = InstallationTypes(input("""choose installation:
1. update vimrc
2. quick
3. full
type anything to quit\n"""))
    except ValueError:
        print("Bye!")
        sys.exit()

    installation_type = InstallationTypes(installation_type)
    if os == SupportedOS.LINUX or os == SupportedOS.MACOS:
        posix(installation_type)
