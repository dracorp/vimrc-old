# vimrc

<!-- vim-markdown-toc GFM -->

    * [Installing this vimrc manually](#installing-this-vimrc-manually)
    * [vim-bootstrap](#vim-bootstrap)
    * [Mappings](#mappings)
        * [General](#general)
        * [Plugins](#plugins)
* [vim-galore](#vim-galore)
    * [Mappings](#mappings-1)
    * [Registers](#registers)
    * [Ranges](#ranges)
    * [Marks](#marks)
    * [Completion](#completion)

<!-- vim-markdown-toc -->

My vim configuration

## Installing this vimrc manually

Although a vimrc is a very personal thing, you may use mine if you
like it. To do so, please do the following:

-   Clone this repo:

    `git clone http://github.com/dracorp/vimrc.git ~/.vim`

    or download the plain source only (but then you will not be able to use git submodule):

    `wget -qO - http://github.com/dracorp/vimrc/tarball/master | tar -xzvf -`

-   Move the content repository to the directory:

    -   _vimfiles_ under Windows (under user's home directory or vim's installation directory)
    -   _.vim_ under Linux
    -   see output command `:version` in vim

-   Check vimrc file and variable 'vimrc_dir'. I don't use path ~/vimfiles in runtimepath under Windows OS

-   Run :PlugInstall command to install plugins

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

-   vim-mardkown

| Key  | Action                                     |
| :--: | :----------------------------------------- |
| `zr` | reduces fold level throughout the buffer   |
| `zR` | opens all folds                            |
| `zm` | increases fold level throughout the buffer |
| `zM` | folds everything all the way               |
| `za` | open a fold your cursor is on              |
| `zA` | open a fold your cursor is on recursively  |
| `zc` | close a fold your cursor is on             |
| `zC` | close a fold your cursor is on recursively |

-   NERDCommenter

|        Key         | Action                 |
| :----------------: | :--------------------- |
|    `<leader>cc`    | NERDCommenterComment   |
|    `<leader>cn`    | NERDCommenterNested    |
| `<leader>c<space>` | NERDCommenterToggle    |
|    `<leader>cm`    | NERDCommenterMinimal   |
|    `<leader>ci`    | NERDCommenterInvert    |
|    `<leader>ci`    | NERDCommenterInvert    |
|    `<leader>cs`    | NERDCommenterSexy      |
|    `<leader>cy`    | NERDCommenterYank      |
|    `<leader>c$`    | NERDCommenterToEOL     |
|    `<leader>cA`    | NERDCommenterAppend    |
|    `<leader>ca`    | NERDCommenterAltDelims |
|    `<leader>cl`    | NERDCommenterAlignLeft |
|    `<leader>cb`    | NERDCommenterAlignBoth |
|    `<leader>cu`    | NERDCommenterUncomment |

-   rest of plugins

|     Key      | Action                            | Plugin               |
| :----------: | --------------------------------- | -------------------- |
|     `F2`     | NERDTreeToggle                    | NERDTree             |
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

# vim-galore

Based on [vim-galore](https://github.com/mhinz/vim-galore/blob/master/README.md)

```vim
" D" Do something if running at least Vim 7.4.42 with +profile enabled.
if (v:version > 704 || v:version == 704 && has('patch42')) && has('profile')
  " do stuff
  " do stuff
endif
```

## Mappings

| Recursive | Non-recursive | Unmap     | Modes                            |
| --------- | ------------- | --------- | -------------------------------- |
| `:map`    | `:noremap`    | `:unmap`  | normal, visual, operator-pending |
| `:nmap`   | `:nnoremap`   | `:nunmap` | normal                           |
| `:xmap`   | `:xnoremap`   | `:xunmap` | visual                           |
| `:cmap`   | `:cnoremap`   | `:cunmap` | command-line                     |
| `:omap`   | `:onoremap`   | `:ounmap` | operator-pending                 |
| `:imap`   | `:inoremap`   | `:iunmap` | insert                           |

## Registers

| Type                | Character              | Filled by? | Readonly? | Contains text from?                                                                                                                                                                                                                 |
| ------------------- | ---------------------- | ---------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Unnamed             | `"`                    | vim        | [ ]       | Last yank or deletion. (`d`, `c`, `s`, `x`, `y`)                                                                                                                                                                                    |
| Numbered            | `0` to `9`             | vim        | [ ]       | Register `0`: Last yank. Register `1`: Last deletion. Register `2`: Second last deletion. And so on. Think of registers `1`-`9` as a read-only [queue](<https://en.wikipedia.org/wiki/Queue_(abstract_data_type)>) with 9 elements. |
| Small delete        | `-`                    | vim        | [ ]       | Last deletion that was less than one line.                                                                                                                                                                                          |
| Named               | `a` to `z`, `A` to `Z` | user       | [ ]       | If you yank to register `a`, you replace its text. If you yank to register `A`, you append to the text in register `a`.                                                                                                             |
| Read-only           | `:`, `.`, `%`          | vim        | [x]       | `:`: Last command, `.`: Last inserted text, `%`: Current filename.                                                                                                                                                                  |
| Alternate buffer    | `#`                    | vim        | [ ]       | Most of the time the previously visited buffer of the current window. See `:h alternate-file`                                                                                                                                       |
| Expression          | `=`                    | user       | [ ]       | Evaluation of the VimL expression that was yanked. E.g. do this in insert mode: `<c-r>=5+5<cr>` and "10" will be inserted in the buffer.                                                                                            |
| Selection           | `+`, `*`               | vim        | [ ]       | `*` and `+` are the [clipboard](#clipboard) registers.                                                                                                                                                                              |
| Drop                | `~`                    | vim        | [x]       | From last drag'n'drop.                                                                                                                                                                                                              |
| Black hole          | `_`                    | vim        | [ ]       | If you don't want any other registers implicitly affected. E.g. `"_dd` deletes the current line without affecting registers `"`, `1`, `+`, `*`.                                                                                     |
| Last search pattern | `/`                    | vim        | [ ]       | Last pattern used with `/`, `?`, `:global`, etc.                                                                                                                                                                                    |

```vim
:let @/ = 'register'
```

## Ranges

| Command             | Lines acted on                                                                            |
| ------------------- | ----------------------------------------------------------------------------------------- |
| `:d`                | Current line.                                                                             |
| `:.d`               | Current line.                                                                             |
| `:1d`               | First line.                                                                               |
| `:$d`               | Last line.                                                                                |
| `:1,$d`             | All lines.                                                                                |
| `:%d`               | All lines (syntactic sugar for `1,$`).                                                    |
| `:.,5d`             | Current line to line 5.                                                                   |
| `:,5d`              | Also current line to line 5.                                                              |
| `:,+3d`             | Current line and the next 3 lines.                                                        |
| `:1,+3d`            | First line to current line + 3.                                                           |
| `:,-3d`             | Current line and the last 3 lines. (Vim will prompt you, since this is a reversed range.) |
| `:3,'xdelete`       | Lines 3 to the line marked by [mark](#marks) x.                                           |
| `:/^foo/,$delete`   | From the next line that starts with "foo" to the end.                                     |
| `:/^foo/+1,$delete` | From the line after the line that starts with "foo" to the end.                           |

## Marks

| Marks     | Set by.. | Usage                                                                                                                                                                                        |
| --------- | -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `a` - `z` | User     | Local to file, thus only valid within one file. Jumping to a lowercase mark, means jumping within the current file.                                                                          |
| `A` - `Z` | User     | Global, thus valid between files. Also called _file marks_. Jumping to a file mark may switch to another buffer.                                                                             |
| `0` - `9` | viminfo  | `0` is the position when the viminfo file was written last. In practice this means when the last Vim process ended. `1` is the position of when the second last Vim process ended and so on. |

Other motions include:

| Motion         | Jump to..                                                     |
| -------------- | ------------------------------------------------------------- |
| `'[`, `` `[ `` | First line or character of previously changed or yanked text. |
| `']`, `` `] `` | Last line or character of previously changed or yanked text.  |
| `'<`, `` `< `` | Beginning line or character of last visual selection.         |
| `'>`, `` `> `` | Ending line or character of last visual selection.            |
| `''`, ` `` `   | Position before the latest jump.                              |
| `'"`, `` `" `` | Position when last exiting the current buffer.                |
| `'^`, `` `^ `` | Position where last insertion stopped.                        |
| `'.`, `` `. `` | Position where last change was made.                          |
| `'(`, `` `( `` | Start of current sentence.                                    |
| `')`, `` `) `` | End of current sentence.                                      |
| `'{`, `` `{ `` | Start of current paragraph.                                   |
| `'}`, `` `} `` | End of current paragraph.                                     |

## Completion

| Mapping      | Kind                                            | Help       |
| ------------ | ----------------------------------------------- | ---------- |
| `<c-x><c-l>` | whole lines                                     | `:h i^x^l` |
| `<c-x><c-n>` | keywords from current file                      | `:h i^x^n` |
| `<c-x><c-k>` | keywords from `'dictionary'` option             | `:h i^x^k` |
| `<c-x><c-t>` | keywords from `'thesaurus'` option              | `:h i^x^t` |
| `<c-x><c-i>` | keywords from current and included files        | `:h i^x^i` |
| `<c-x><c-]>` | tags                                            | `:h i^x^]` |
| `<c-x><c-f>` | file names                                      | `:h i^x^f` |
| `<c-x><c-d>` | definitions or macros                           | `:h i^x^d` |
| `<c-x><c-v>` | Vim commands                                    | `:h i^x^v` |
| `<c-x><c-u>` | user defined (as specified in `'completefunc'`) | `:h i^x^u` |
| `<c-x><c-o>` | omni completion (as specified in `'omnifunc'`)  | `:h i^x^o` |
| `<c-x>s`     | spelling suggestions                            | `:h i^Xs`  |
