vimrc
=====

My vim configuration

## Installing this vimrc manually

Although a vimrc is a very personal thing, you may use mine if you
like it. To do so, please do the following:

* Clone this repo:

    `git clone http://github.com/dracorp/vimrc.git ~/.vim`

    or download the plain source only (but then you will not be able to use git submodule):

    `wget -qO - http://github.com/dracorp/vimrc/tarball/master | tar -xzvf -`

* Move the content repository to the directory:

    * *vimfiles* under Windows (under user's home directory or vim's installation directory)
    * *.vim* under Linux
    * see output command `:version` in vim

* Check vimrc file and variable 'vimrc_dir'. I don't use path ~/vimfiles in runtimepath under Windows OS

* Run :PlugInstall command to install plugins
