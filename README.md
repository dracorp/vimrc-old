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

|  Key   | Action                        | Mode   |
| :----: | :---------------------------- | :----- |
|  `;`   | Local Leader                  | All    |
|  `z0`  | Sets foldlevel 0              | Normal |
|  `z1`  | Sets foldlevel 1              | Normal |
|  `z2`  | Sets foldlevel 2              | Normal |
|  `z3`  | Sets foldlevel 3              | Normal |
|  `z4`  | Sets foldlevel 4              | Normal |
|  `z5`  | Sets foldlevel 5              | Normal |
|  `F1`  | Show the keyword under cursor |        |
| `S-F6` | toggle paste mode             | All    |
| `F10`  | Refresh syntax highlight      |

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

|     Key      | Action                            | Plugin               |
| :----------: | --------------------------------- | -------------------- |
|     `F2`     | NERDTreeToggle                    | NERDTree             |
|     `F3`     | NERDTreeFind                      | NERDTree             |
|     `F5`     | MundoToggle                       | vim-mundo            |
|     `F9`     | SyntasticToggleMode               | syntastic            |
|   `S-F11`    | TlistToggle                       | taglist              |
|    `F12`     | TagbarToggle                      | tagbar               |
|   `S-F12`    | Vista                             | vista.vim            |
| `<Leader>fu` | CtrlPFunky                        | ctrlp-funky          |
| `<Leader>fU` | CtrlPFunky on a word under cursor | ctrlp-funky          |
|    `Tab`     | Word completion                   | coc.nvim             |
| `<Leader>e`  | FZF                               | fzf.vim              |
| `<Leader>y`  | History                           | fzf.vim              |
|     `/`      | incsearch-forward                 | incsearch.vim        |
|     `?`      | incsearch-backward                | incsearch.vim        |
|     `g/`     | incsearch-stay                    | incsearch.vim        |
|     `gx`     | openbrowser                       | open-browser.vim     |
|   `ctrl-N`   | bnext                             | vim-buftabline       |
|   `ctrl-P`   | bprev                             | vim-buftabline       |
| `<Leader>m`  | InstantMarkdownPreview            | vim-instant-markdown |
|   `ctrl-T`   | Toggle                            | vim-toggle           |
