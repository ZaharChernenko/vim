import os
import shutil
import subprocess
import sys
from typing import Optional

from .common import (
    HOME_DIR,
    PackageManagers,
    PlatformSetup,
    SupportedOS,
    startPrint,
    successPrint,
)


def getPlatformSetup() -> Optional[PlatformSetup]:
    try:
        platform = SupportedOS(sys.platform)
    except ValueError:
        return None

    if platform == SupportedOS.MACOS:
        return PlatformSetup(SupportedOS.MACOS, PackageManagers.BREW)

    if platform == SupportedOS.LINUX:
        for manager in PackageManagers:
            try:
                runCommand([manager.value, "--version"])
                return PlatformSetup(SupportedOS.LINUX, manager)
            except subprocess.CalledProcessError:
                pass
            except FileNotFoundError:
                pass

    return None


def copyFile(source_path: str, target_path: str, source_filename: str, target_filename: Optional[str] = None):
    """Copies file, if it exists then dumps it to the temp dir"""
    target_filename = target_filename or source_filename
    if os.path.exists(f"{target_path}/{target_filename}"):
        print(f"dump current {target_filename}")
        shutil.copy(f"{target_path}/{target_filename}", f"{HOME_DIR}/temp/{target_filename}")
    shutil.copy(f"{source_path}/{source_filename}", f"{target_path}/{target_filename}")
    successPrint(f"{target_filename} was copied")


def createDirectory(path: str):
    """Creates dir if it doesn't exist, else nothing"""
    if not os.path.exists(path):
        os.makedirs(path)
    successPrint(f"{path} directory was created")


def copyDirectory(source_dir: str, target_dir: str):
    """Copies directory if it doesn't exists, otherwise adds and rewrites new files"""
    shutil.copytree(source_dir, target_dir, dirs_exist_ok=True)
    successPrint(f"{target_dir} directory was copied")


def runCommand(command, is_print: bool = False):
    if not is_print:
        # запускаем программу в дочернем процессе
        subprocess.run(
            command,
            check=True,  # выбрасывает исключение при ненулевом коде возврата
            stdout=subprocess.PIPE,  # захватывает стандартный вывод
            stderr=subprocess.PIPE,  # захватывает стандартный вывод ошибок
            text=True,
            encoding="utf-8",
        )
    else:
        with subprocess.Popen(
            command,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding="utf-8",
        ) as process:
            output, error = process.communicate()
            print(output, error)


def installPlugins():
    startPrint("installing plugins")
    # перенаправляем вывод в devnull, вместо текущей консоли
    with open("/dev/null", "w") as devnull:
        # запускаем программу в дочернем процессе
        return subprocess.Popen(
            ["vim", "--cmd", f"silent! source {HOME_DIR}/.vimrc", "--cmd", "PlugInstall", "--cmd", "qa!"],
            stdout=devnull,
            stderr=devnull,
        )
