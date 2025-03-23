import os
import sys

if (module_dir := os.path.dirname(os.path.abspath(__file__))) not in sys.path:
    sys.path.insert(0, module_dir)

from TCompleterContext import TCompleterContext


def Settings(**kwargs):
    return TCompleterContext.complete(**kwargs)
