class RedException(Exception):
    red_template = "\033[31m{}\033[0m"
    message = "RedException"

    def __str__(self):
        return self.red_template.format(self.message)


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


class PylintInstallationFailed(RedException):
    message = "Unable to install pylint"


class CopyingPylintcFailed(RedException):
    message = "Copying .pylintrc failed"


class PylintSetupFailed(RedException):
    message = "Unable to setup .pylintrc"


class CopyingAutopepFailed(RedException):
    message = "Copying pycodestyle failed"


class YCMInstallationFailed(RedException):
    message = "Installation ycm failed"


class CopyingYCMConfFailed(RedException):
    message = "Failed to copy .ycm_extra_conf.py"


class VimspectorSetupFailed(RedException):
    message = "Unable to setup vimspector"
