class RedException(Exception):
    red_template = "\033[31m{}\033[0m"
    message = "RedException"

    def __str__(self):
        return self.red_template.format(self.message)


class CopyingFileFailed(RedException):
    message = "Failed to copy file"


class VimInstallationFailed(RedException):
    message = "Unable to install vim and curl"


class VimPlugInstallationFailed(RedException):
    message = "Unable to install vim-plug"


class CopyingVimrcFailed(RedException):
    message = "Copying .vimrc failed"


class FontsInstallationFailed(RedException):
    message = "Copying fonts failed"


class PipInstallationFailed(RedException):
    message = "Unable to install pip"


class PythonToolsInstallationFailed(RedException):
    message = "Unable to install linters"


class CppToolsInstallationFailed(RedException):
    message = "Unable to install cpp tools"


class SetupJSFailed(RedException):
    message = "Unable to setup JS"


class YCMInstallationFailed(RedException):
    message = "Installation ycm failed"


class CopyingYCMConfFailed(RedException):
    message = "Failed to copy .ycm_extra_conf.py"


class VimspectorSetupFailed(RedException):
    message = "Unable to setup vimspector"


class CopyingScriptsFailed(RedException):
    message = "Copying scripts failed"
