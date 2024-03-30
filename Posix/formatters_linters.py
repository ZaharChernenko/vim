from Posix.cpp import setupClangFormat
from Posix.python import setupAutopep, setupPylintrc


def setupFormattersLinters():
    # python
    setupAutopep()
    setupPylintrc()
    # cpp
    setupClangFormat()
