from VimInstaller import InstallationTypes, VimInstaller

if __name__ == "__main__":
    import argparse
    import sys

    parser: argparse.ArgumentParser = argparse.ArgumentParser(description="Vim installer")
    parser.add_argument(
        "-f",
        "--full",
        action="store_const",
        const=InstallationTypes.FULL,
        default=InstallationTypes.NO_ACTION,
        help="Full config installation",
    )
    parser.add_argument(
        "-m",
        "--minimal",
        action="store_const",
        const=InstallationTypes.MINIMAL,
        default=InstallationTypes.NO_ACTION,
        help="Minimal config installation",
    )
    parser.add_argument(
        "-S",
        "--sync_full",
        action="store_const",
        const=InstallationTypes.SYNC_FULL,
        default=InstallationTypes.NO_ACTION,
        help="Vimrc synchronization full config",
    )
    parser.add_argument(
        "-s",
        "--sync_minimal",
        action="store_const",
        const=InstallationTypes.SYNC_MINIMAL,
        default=InstallationTypes.NO_ACTION,
        help="Vimrc synchronization mininal config",
    )
    args: argparse.Namespace = parser.parse_args()

    try:
        mode: InstallationTypes = InstallationTypes(sum((args.full, args.minimal, args.sync_full, args.sync_minimal)))
    except ValueError:
        print("Error, only one flag must be chosen")
        parser.print_help()
        sys.exit(1)

    vim_installer: VimInstaller = VimInstaller(mode)
    vim_installer()
