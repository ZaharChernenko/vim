import os
import shutil
import subprocess

from .common import (
    HOME_DIR,
    RED_TEMPLATE,
    YELLOW_TEMPLATE,
    VimInstallerException,
    successPrint,
)


def copyFile(source_path: str, target_path: str, filename: str):
    """Copies file, if it exists then dumps it to the temp dir"""
    if os.path.exists(f"{target_path}/{filename}"):
        print(f"dump current {filename}")
        shutil.copy(f"{target_path}/{filename}", f"{HOME_DIR}/temp/{filename}")
    shutil.copy(f"{source_path}/{filename}", f"{target_path}/{filename}")
    successPrint(f"{filename} was copied")


def createDirectory(path: str):
    """Creates dir if it doesn't exist, else nothing"""
    if not os.path.exists(path):
        os.makedirs(path)
    successPrint(f"{path} directory was created")


def copyDirectory(source_dir: str, target_dir: str):
    """Copies directory if it doesn't exists, otherwise adds and rewrites new files"""
    shutil.copytree(source_dir, target_dir, dirs_exist_ok=True)


def runCommand(command: list[str], definition: str):
    print(YELLOW_TEMPLATE.format(definition))
    try:
        subprocess.run(
            command,
            check=True,  # выбрасывает исключение при ненулевом коде возврата
            stdout=subprocess.PIPE,  # захватывает стандартный вывод
            stderr=subprocess.PIPE,  # захватывает стандартный вывод ошибок
            text=True,
        )
        successPrint("completed")

    except subprocess.CalledProcessError as e:
        print(RED_TEMPLATE.format(f"Error executing command: {e}"))
        print(f"Return code: {e.returncode}")
        print(f"Error output: {e.stderr}")
        raise VimInstallerException from e
