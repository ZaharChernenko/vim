import os
import sys

from .common import RED_TEMPLATE, startPrint, successPrint
from .common_tools import *

if os.name == "posix":
    from .posix_tools import *
