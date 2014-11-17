vimrc
=====

My vim configuration

Installing this vimrc manually
==============================
Although a vimrc is a very personal thing, you may use mine if you
like it.  To do so, please do the following:

1. Clone this repo:

    `git clone http://github.com/dracorp/vimrc.git`

or download the plain source only (but you can't use git submodule):

    `wget -qO - http://github.com/dracorp/vimrc/tarball/master | tar -xzvf -`

3. Change directory:

    `cd vimrc`

4. Fetch submodules:

    `git submodule init`

    `git submodule update`

5. Move the content repository to the directory:

    * *vimfiles* under Windows (under user's home directory or vim's installation directory)
    * *.vim* under Linux
    * see :version under vim

6. Check vimrc file and variable 'vimrc_dir'. I don't use path ~/vimfiles in runtimepath under Windows OS

7. In future you'll be able to upgrade submodules:

    `git submodule foreach git pull origin master`
