# vim

# installation
1) install from terminal, then install MacVim for Mac or Gvim for Linux

   
2) install vim-plug:
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

4) put in home directory (~) .vimrc
5) launch vim and write :PlugInstall
6) Put colorsheme in .vim/colors
7) install pylint:
   python3 -m pip install pylint
8) create .pylintrc file:
  pylint --generate-rcfile > ~/.pylintrc
9) install YCM:
   for fedora:
   - sudo dnf install mono-complete java-17-openjdk java-17-openjdk-devel npm
   - sudo dnf install nodejs golang
   - cd ~/.vim/bundle/YouCompleteMe
   - python3 install.py --all
