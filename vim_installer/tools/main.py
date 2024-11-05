import os
import shutil
import subprocess

from common import (
    HOME_DIR,
    RED_TEMPLATE,
    YELLOW_TEMPLATE,
    VimInstallerException,
    successPrint,
)


def copyFile(source_path: str, target_path: str, source_filename: str, target_filename: None | str = None):
    """Copies file, if it exists then dumps it to the temp dir"""
    target_filename = target_filename or source_filename
    print(f"{target_path}/{target_filename}")
    if os.path.exists(f"{target_path}/{target_filename}"):
        print(f"dump current {target_filename}")
        shutil.copy(f"{target_path}/{target_filename}", f"{HOME_DIR}/temp/{target_filename}")
    shutil.copy(f"{source_path}/{source_filename}", f"{target_path}/{target_filename}")
    successPrint(f"{target_filename} was copied")
