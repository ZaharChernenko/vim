import os

import ycm_core

import common


class TCpp:
    AUTOCOMPLETE_PATH: str = "build/compile_commands.json"
    HEADER_EXTENSIONS: set[str] = {".h", ".hxx", ".hpp", ".hh"}
    SOURCE_EXTENSIONS: list[str] = [".cpp", ".cxx", ".cc", ".c", ".m", ".mm"]

    @classmethod
    def isHeaderFile(cls, filename) -> bool:
        extension = os.path.splitext(filename)[1]
        return extension in cls.HEADER_EXTENSIONS

    @classmethod
    def findCorrespondingSourceFile(cls, filename):
        if cls.isHeaderFile(filename):
            basename = os.path.splitext(filename)[0]
            for extension in cls.SOURCE_EXTENSIONS:
                replacement_file = basename + extension
                if os.path.exists(replacement_file):
                    return replacement_file
        return filename

    @classmethod
    def getDatabase(cls, source_path: str):
        """
        Set this to the absolute path to the folder (NOT the file!) containing the
        compile_commands.json file to use that instead of 'flags'. See here for
        more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html

        You can get CMake to generate this file for you by adding:
        set( CMAKE_EXPORT_COMPILE_COMMANDS 1 )
        to your CMakeLists.txt file.

        Most projects will NOT need to set this to anything; you can just change the
        'flags' list of compilation flags. Notice that YCM itself uses that approach.
        нужно для автодополнения в проекте с системами сборки, например CMake
        """
        database_folder: str = common.findNodeUpwards(source_path, cls.AUTOCOMPLETE_PATH)
        return ycm_core.CompilationDatabase(database_folder) if os.path.exists(database_folder) else None
