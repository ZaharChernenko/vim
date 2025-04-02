import abc
import os
import sysconfig
import typing

import ycm_core

import path_utils
from completers import ICompleter


class TCppCompleter(ICompleter):
    DATABASE_NODES: typing.Final[tuple[str, ...]] = (
        os.path.normpath("build/Debug/compile_commands.json"),
        os.path.normpath("build/Release/compile_commands.json"),
        os.path.normpath("build/compile_commands.json"),
    )
    HEADER_EXTENSIONS: typing.Final[frozenset[str]] = frozenset((".h", ".hxx", ".hpp", ".hh"))
    SOURCE_EXTENSIONS: typing.Final[tuple[str, ...]] = (".cpp", ".cxx", ".cc", ".c", ".m", ".mm")

    # These are the compilation flags that will be used in case there's no
    # compilation database set (by default, one is not set).
    # CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
    COMPILATION_FLAGS: typing.Final[list[str]] = [
        "-Wall",
        "-Wextra",
        "-Werror",
        "-Wno-long-long",
        "-Wno-variadic-macros",
        "-fexceptions",
        "-DNDEBUG",
        # THIS IS IMPORTANT! Without the '-x' flag, Clang won't know which language to
        # use when compiling headers. So it will guess. Badly. So C++ headers will be
        # compiled as C headers. You don't want that so ALWAYS specify the '-x' flag.
        # For a C project, you would set this to 'c' instead of 'c++'.
        "-x",
        "c++",
        "-isystem",
        sysconfig.get_path("include"),
        "-isystem",
        "cpp/llvm/include",
        "-isystem",
        "cpp/llvm/tools/clang/include",
        "-std=c++2a",
    ]

    @classmethod
    @abc.abstractmethod
    def complete(cls, **kwargs) -> dict:
        """
        If the file is a header, try to find the corresponding source file and
        retrieve its flags from the compilation database if using one. This is
        necessary since compilation databases don't have entries for header files.
        In addition, use this source file as the translation unit. This makes it
        possible to jump from a declaration in the header file to its definition
        in the corresponding source file.
        """

        raise NotImplementedError()

    @classmethod
    def is_header_file(cls, filename: str) -> bool:
        extension = os.path.splitext(filename)[1]
        return extension in cls.HEADER_EXTENSIONS

    @classmethod
    def find_corresponding_source_file(cls, filename: str) -> str:
        if cls.is_header_file(filename):
            file_path_without_extension = os.path.splitext(filename)[0]
            for extension in cls.SOURCE_EXTENSIONS:
                replacement_file = file_path_without_extension + extension
                if os.path.exists(replacement_file):
                    return replacement_file
        return filename

    @classmethod
    def find_database_path(cls, source_path: str) -> typing.Optional[str]:
        """
        Set this to the absolute path to the folder (NOT the file!) containing the
        compile_commands.json file to use that instead of 'flags'. See here for
        more details: http://clang.llvm.org/docs/JSONCompilationDatabase.html

        You can get CMake to generate this file for you by adding:
        set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
        to your CMakeLists.txt file.

        Most projects will NOT need to set this to anything; you can just change the
        'flags' list of compilation flags. Notice that YCM itself uses that approach.
        """
        database_path: typing.Optional[str] = path_utils.bfs_newest_node_upwards(source_path, cls.DATABASE_NODES)
        return None if database_path is None else os.path.dirname(database_path)


class TClangCompleter(TCppCompleter):
    @classmethod
    def complete(cls, **kwargs) -> dict:
        filename: str = kwargs["filename"]
        source_filename: str = cls.find_corresponding_source_file(filename)
        database_path: typing.Optional[str] = cls.find_database_path(os.path.dirname(filename))
        if database_path is None:
            return {
                "flags": cls.COMPILATION_FLAGS,
                "override_filename": source_filename,
            }

        database = ycm_core.CompilationDatabase(database_path)
        compilation_info = database.GetCompilationInfoForFile(source_filename)
        # Bear in mind that compilation_info.compiler_flags_ does NOT return a
        # python list, but a "list-like" StringVec object.
        return {
            "flags": list(compilation_info.compiler_flags_),
            "include_paths_relative_to_dir": compilation_info.compiler_working_dir_,
            "override_filename": source_filename,
        }


class TClangdCompleter(TCppCompleter):
    @classmethod
    def complete(cls, **kwargs) -> dict:
        filename: str = kwargs["filename"]
        source_filename: str = cls.find_corresponding_source_file(filename)
        database_path: typing.Optional[str] = cls.find_database_path(os.path.dirname(filename))
        if database_path is None:
            return {
                "flags": cls.COMPILATION_FLAGS,
                "override_filename": source_filename,
            }
        return {"ls": {"compilationDatabasePath": database_path}}
