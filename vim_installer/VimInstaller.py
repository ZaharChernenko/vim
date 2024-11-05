from enum import IntEnum

from tools import *


class InstallationTypes(IntEnum):
    NO_ACTION = 0b000
    FULL = 0b001
    MINIMAL = 0b010
    SYNC = 0b100


class VimInstaller:
    def __init__(self, installation_type: InstallationTypes):
        pass

    def run(self):
        print("run")
        pass
