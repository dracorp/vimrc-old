vimrc
=====

My vim configuration

Installing this vimrc manually
==============================
Although a vimrc is a very personal thing, you may use mine if you
like it.  To do so, please do the following:

1. Clone this repo:

    `git clone http://github.com/dracorp/vimrc.git`

    or download the plain source only::

   	`wget -qO - http://github.com/dracorp/vimrc/tarball/master | tar -xzvf -`

2. Fetch submodules:

   	`git submodule init`

    `git submodule update`

3. Copy the repository to the directory:
    * *vimfiles* under Windows
    * *.vim* under Linux

4. Do symlink in your $HOME to:
    * *.vimrc* under Linux
    * *_vimrc* under Windows
