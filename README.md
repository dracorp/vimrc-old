vimrc
=====

My vim configuration

## Installing this vimrc manually

Although a vimrc is a very personal thing, you may use mine if you
like it.  To do so, please do the following:

1. Clone this repo:

    `git clone http://github.com/dracorp/vimrc.git`

    or download the plain source only (but then you will not be able to use git submodule):

    `wget -qO - http://github.com/dracorp/vimrc/tarball/master | tar -xzvf -`

I've migrated from pathogen to [Vundle](https://github.com/gmarik/Vundle.vim) so you can skip next steps or no.

2. Change directory:

    `cd vimrc`

3. Fetch submodules:

    `git submodule init`

    `git submodule update`

4. Move the content repository to the directory:

    * *vimfiles* under Windows (under user's home directory or vim's installation directory)
    * *.vim* under Linux
    * see output command `:version` in vim

5. Check vimrc file and variable 'vimrc_dir'. I don't use path ~/vimfiles in runtimepath under Windows OS

6. In future you'll be able to upgrade submodules:

    `git submodule foreach git pull origin master`

    or

    `git submodule update --init` when a new module arrives

7. If you have a problem with a plugin then add line to the problematic submodules in _.gitmodules_:

    `ignore = dirty`

