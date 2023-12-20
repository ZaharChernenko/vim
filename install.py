import sys
from GlobalVars import InstallationTypes, SupportedOS, getOS

if __name__ == "__main__":
    os: SupportedOS = getOS()

    try:
        installation_type = InstallationTypes(input("""choose installation:
1. update vimrc
2. quick
3. full
type anything to quit\n"""))

    except ValueError:
        print("Bye!")
        sys.exit()

    if os == SupportedOS.LINUX or os == SupportedOS.MACOS:
        from Posix.posixInstaller import posix
        posix(installation_type)
