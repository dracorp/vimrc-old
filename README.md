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

## vim-bootstrap

Based on [vim-bootstrap](https://vim-bootstrap.com/) Vim does these things automatically.

## Mappings

### General

Leader key is <kbd>\\</kbd>

|     Key      | Action                        | Mode   |
| :----------: | :---------------------------- | :----- |
| <kbd>;</kbd> | Local Leader                  | All    |
|     `;`      | Local Leader                  | All    |
|      z0      | Sets foldlevel 0              | Normal |
|      z1      | Sets foldlevel 1              | Normal |
|      z2      | Sets foldlevel 2              | Normal |
|      z3      | Sets foldlevel 3              | Normal |
|      z4      | Sets foldlevel 4              | Normal |
|      z5      | Sets foldlevel 5              | Normal |
|     `F1`     | Show the keyword under cursor |        |
|    `S-F6`    | toggle paste mode             | All    |

### Plugins

* vim-mardkown

|  Key  | Action                                     |
| :---: | :----------------------------------------- |
| `zr`  | reduces fold level throughout the buffer   |
| `zR`  | opens all folds                            |
| `zm`  | increases fold level throughout the buffer |
| `zM`  | folds everything all the way               |
| `za`  | open a fold your cursor is on              |
| `zA`  | open a fold your cursor is on recursively  |
| `zc`  | close a fold your cursor is on             |
| `zC`  | close a fold your cursor is on recursively |

|   Key   | Action                   |
| :-----: | ------------------------ |
|  `F2`   | NERDTreeToggle           |
|  `F3`   | NERDTreeFind             |
|  `F5`   | MundoToggle              |
|  `F9`   | SyntasticToggleMode      |
|  `F10`  | Refresh syntax highlight |
| `S-F11` | TlistToggle              |
|  `F12`  | TagbarToggle             |
| `S-F12` | Vista                    |
