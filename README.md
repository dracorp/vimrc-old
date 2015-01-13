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

3. Change directory:

    `cd vimrc`

4. Fetch submodules:

    `git submodule init`

    `git submodule update`

5. Move the content repository to the directory:

    * *vimfiles* under Windows (under user's home directory or vim's installation directory)
    * *.vim* under Linux
    * see output command `:version` in vim

6. Check vimrc file and variable 'vimrc_dir'. I don't use path ~/vimfiles in runtimepath under Windows OS

7. In future you'll be able to upgrade submodules:

    `git submodule foreach git pull origin master`

    or

    `git submodule update --init` when a new module arrives

8. If you have a problem with a plugin then add line to the problematic submodules in _.gitmodules_:

    `ignore = dirty`

## Bundle plugins

* [awk-support](https://github.com/vim-scripts/awk-support.vim.git)
* [perl-support](https://github.com/vim-scripts/perl-support.vim.git)
* [bash-support](https://github.com/vim-scripts/bash-support.vim.git)
* [sudo-edit](https://github.com/vim-scripts/SudoEdit.vim.git)
* [supertab](https://github.com/vim-scripts/SuperTab--Van-Dewoestine.git)
* [vim-lesscss](https://github.com/vim-scripts/vim-lesscss)
* [vim-misc](https://github.com/vim-scripts/vim-misc.git)
* [vim-support](https://github.com/vim-scripts/Vim-Support.git)
* [sensible](https://github.com/tpope/vim-sensible.git)
* [extradite](https://github.com/vim-scripts/extradite.vim.git)
* [vim-colorscheme-switcher](https://github.com/xolox/vim-colorscheme-switcher.git)
* [vim-speeddating](https://github.com/tpope/vim-speeddating.git)
* [vim-scriptease](https://github.com/tpope/vim-scriptease.git)
* [git-support](https://github.com/vim-scripts/Git-Support.git)
* [vim-markdown](https://github.com/plasticboy/vim-markdown.git)
* [merginal](https://github.com/vim-scripts/Merginal.git)
* [closetag.vim](https://github.com/vim-scripts/closetag.vim.git)
* [xmledit](https://github.com/vim-scripts/xmledit.git)
* [vim-flake8](https://github.com/nvie/vim-flake8.git)
* [xslt](https://github.com/vim-scripts/xslt.git)
* [restore_view.vim](https://github.com/vim-scripts/restore_view.vim.git)
* [Tabmerge](https://github.com/vim-scripts/Tabmerge.git)
* [mru](https://github.com/yegappan/mru.git)
* [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized.git)
* [xml.vim](https://github.com/vim-scripts/xml.vim.git)
* [whitespace-syntax-highlight](https://github.com/vim-scripts/whitespace-syntax-highlight.git)
* [syntastic](https://github.com/scrooloose/syntastic.git)
* [jshint2.vim](https://github.com/Shutnik/jshint2.vim.git)
* [vim-airline](https://github.com/bling/vim-airline.git)
* [tagbar](https://github.com/majutsushi/tagbar.git)
* [ctrlp.vim](https://github.com/kien/ctrlp.vim.git)
* [csv.vim](https://github.com/chrisbra/csv.vim.git)
* [unite.vim](https://github.com/Shougo/unite.vim.git)
* [vim-fugitive](https://github.com/tpope/vim-fugitive.git)
* [undotree](https://github.com/mbbill/undotree.git)
* [promptline.vim](https://github.com/edkolev/promptline.vim.git)
* [vim-gitgutter](https://github.com/airblade/vim-gitgutter.git)
* [DrawIt](https://github.com/vim-scripts/DrawIt.git)
* [jQuery](https://github.com/vim-scripts/jQuery.git)
* [vim-repeat](git://github.com/tpope/vim-repeat.git)
* [vimproc.vim](https://github.com/Shougo/vimproc.vim.git)
* [vim-easymotion](https://github.com/Lokaltog/vim-easymotion)
* [TWiki-Syntax](https://github.com/vim-scripts/TWiki-Syntax.git)
* [Toggle](https://github.com/vim-scripts/Toggle.git)
* [vimwiki](https://github.com/vimwiki/vimwiki.git)
* [switch.vim](https://github.com/AndrewRadev/switch.vim.git)
* [permut.vim](https://github.com/vim-scripts/permut.vim.git)
* [darcula](https://github.com/blueshirts/darcula.git)
* [yowish](https://github.com/vim-scripts/yowish.git)
* [vcscommand.vim](https://github.com/vim-scripts/vcscommand.vim.git)

