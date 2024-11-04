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


runCommand(["curl", "asdf"], "run vim")
