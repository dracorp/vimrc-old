" vim: textwidth=0 
"===================================================================================
"         FILE:  .vimrc
"  DESCRIPTION:  suggestion for a personal configuration file ~/.vimrc
"       AUTHOR:  Piotr Rogoża
"===================================================================================
"
"===================================================================================
" GENERAL SETTINGS
"===================================================================================
" podstawowy typ plików
set ft=txt
" ilość kolorów
set t_Co=8
" podstawowe kodowanie
scriptencoding utf-8
"-------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
"-------------------------------------------------------------------------------
set nocompatible
"
" opcja behave informuje jak ma się zachowywać mysz przy zaznaczaniu, wpływa
" na selectmode mousemodel keymodel selection
behave xterm
"
"===================================================================================
" Include other configuration files
"===================================================================================
"
if filereadable("$HOME/.vim/vimrc.keys.vim")
    source $HOME/.vim/vimrc.keys.vim
endif
"
if filereadable("$HOME/.vim/vimrc.functions.vim")
    source $HOME/.vim/vimrc.functions.vim
endif
"
"-------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
"-------------------------------------------------------------------------------
filetype  plugin on
filetype  indent on
"
"-------------------------------------------------------------------------------
" Switch syntax highlighting on.
"-------------------------------------------------------------------------------
"Podświetlanie składni (tylko gdy kolory są dostępne)
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif
" - central backup directory (has to be created), nie może występić spacja po znaku równości(=)
set backupdir =$HOME/.vim.backupdir
"set dictionary=$HOME/.vim/wordlists/german.list,$HOME/.vim/wordlists/english.list
"
" Using a backupdir under UNIX/Linux: you may want to include a line similar to
"   find  $HOME/.vim.backupdir -name "*" -type f -mtime +60 -exec rm -f {} \;
" in one of your shell startup files (e.g. $HOME/.profile)
"
"set runtimepath+=/etc/vim "dodanie do ścieżki z plikami konfiguracyjnymi /etc/vim/
"-------------------------------------------------------------------------------
" Various settings
"-------------------------------------------------------------------------------
set foldenable
set foldmethod=marker  			" używaj markerów do zwinięć
"set foldmarek={{{,}}}
" Wyświetlanie końca lini, TAB, ciągłych spacji na końcu lini, przed i po złamaniu wiersza
" eol, tab, trail, extends, precedes
set listchars=tab:>-,eol:$,trail:-,nbsp:%
"set listchars=tab:>.,eol:\$     " strings to use in 'list' mode
set linebreak
set laststatus=2 				" Linia statusu na dole
set autoindent                  " copy indent from current line
set smartindent                 " smart autoindenting when starting a new line
set nonumber 						" Numerowanie wierszy/łamanie wierszy
set wrapscan 					" przy wyszukiwaniu będzie zaczynał od początku pliku, przy no tylko do końca
"set autoread                   " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
set backspace=indent,eol,start  " backspacing over everything in insert mode
" definiuje które klawisze przenoszą kursor do nowej linii gdy jest na końcu/początku lini
" backspace, space, <left>, <right> w Normal, i w Insert
set whichwrap=b,s,<,>,[,],h,l
set backup                      " keep a backup file
"set writebackup                " Bez backup'ów(~) ale rób kopie bezpieczeństwa. W razie udanego zapisu kasuje ją
"set patchmode=.orig            " rób pierwszą kopię pliku przy edycji
set browsedir=current           " which directory to use for the file browser
set complete+=k                 " scan the files given with the 'dictionary' option
set history=50                  " keep 50 lines of command line history
set hlsearch                    " highlight the last used search pattern
set incsearch                   " do incremental searching
set mouse=v                     " enable the use of the mouse
set mousehide                   " Hide the mouse when typing text
"set mousemodel=extend           "szybkie wyszuiwanie za pomocą myszki
set wrap                      " do not wrap lines
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time
set showmode 					" Pokaż tryb w lewym-dolnym rogu
set showcmd                     " display incomplete commands
set display+=lastline           " Pokazuje na dole ostatnią linię?
set so=3                        " przy przewijaniu trzymaj się n lini od końca/początku ekranu
" Formatowanie
"set textwidth=72               " domyślna wartość: czasem wato ustawić szerokość ekranu na 78 kolumn
" automatyczne formatowanie, gq je wywołuje, domyślne wartości: formatoptions=croql :help fo-table
set formatoptions+=1            " 1 przenosi ostatni, pojedynczy znak, taki jak i a z w, do następnej linii.
set formatoptions+=t            " t automatyczne zwijanie do textwidth
set formatoptions-=c            " c automatyczne zwijanie do textwidth komentarzy

set showbreak+=+\               " załamanie lini oznacza przez
"set visualbell                 " visual bell instead of beeping
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
set wildmenu                    " command-line completion in an enhanced mode
set wildmode=longest,list       " Uzupełnianie po <TAB> w lini poleceń wszystkich możliwości a nie jedną wartość
set tabstop=4                   " Ile 'spacji' na tabulację, przy opcji expandtab
set softtabstop=4 "ile spacji przy TAB i BACKSPACE

set expandtab                   " Zamieniaj tabulacje na spacje
set shiftwidth=4                " ilość spacji dla każdego wcięcia (auto)indent; Wcinanie i usuwanie wcięć o 4 kolumny
set shiftround                  " Wcinanie i usuwanie wcięć do najbliższego przystanku tabulatora
set modeline                    " modeline to komendy dla vima w komentarzach innych plików 
"żeby vim nie przycinał na dużych plikach gdy jest kolorowanie składni
syntax sync minlines=30
syntax sync maxlines=40
set synmaxcol=500
set splitbelow                  " polecenie :sp umieszcza nowe okno pod aktywnym
set splitright                  " polecenie :vs umieszcza nowe po prawej stronie aktywnego
set ignorecase smartcase        " Ignorowanie wielkości liter podczas wyszukiwania
set incsearch
set infercase
set title                       " ustawienie tytułu okna xterm
set tildeop                     " Tylda(~) robi za operator, można teraz używać jej np. tak: ~w ~~
set iskeyword+=-                " jakie znaki należą do słowa, np. dla klawisza w
set cmdheight=1                 " Make command line two lines high
set pastetoggle=<F6>            " Przełączanie trybu paste. Wygodne przy wklejaniu
"-------------------------------------------------------------------------------
"  autocommand
"-------------------------------------------------------------------------------
"
if has("autocmd")
    " Zaczynaj nowy plik w trybie Insert
    "autocmd BufNewFile * startinsert
    "
    " Ustaw typy plików dla:
    au BufRead,BufNewFile ~/.mc/ini set filetype=dosini
    au BufRead,BufNewFile dhcpd.conf set filetype=dhcpd
    au BufRead,BufNewFile */nginx/conf/* set ft=nginx
    "
    " Automatyczna zmiana katalogu do tego, w ktorym jest aktualnie edytowany plik.
    " Przydatne gdy chcemy otworzyc inny z tego samego katalogu
    " http://vim.sourceforge.net/tip_view.php?tip_id=101
    " mozna tez uzyc set acd, ale ta opcja nie dziala z pewnymi wtyczkami, zobacz :he acd
    au BufEnter * :cd %:p:h
    " Zablokuj pliki tylko do odczytu
    "au BufReadPost * :call CheckReadonly()
 endif " has("autocmd")
"
"-------------------------------------------------------------------------------
"  ENCODING
"-------------------------------------------------------------------------------
"
set fileencodings=utf-8,iso8859-2,cp1250,usc-bom,iso8859-1,utf-16,default
"'termencoding' jest zestawem znaków dla klawiatury, oraz (tylko w konsolowym Vimie) dla ekranu.
"'printencoding' jest zestawem znaków dla drukarki, jeśli oba +printer i +postscript są wkompilowane.
"Konwersja przebiega następująco, jeśli zestawy znaków różnią się a metoda konwersji jest znana:
"    * 'fileencoding' na 'encoding' podczas czytania z dysku
"    * 'termencoding' na 'encoding' podczas wpisywania z klawiatury
"    * (tylko w konsolowym Vimie): 'encoding' na 'termencoding' podczas wyświetlania
"    * 'encoding' na 'printencoding' podczas drukowania przez PostScript
"    * 'encoding' na 'fileencoding' podczas zapisu na dysk
"	Użycie ":w ++enc=XXX" nie zmienia zachowania domyślnego (ang. ulterior?) zapisu.
"	Użycie 'fileencoding' (które lepiej zmieniać przez ":setlocal" niż ":set") zmienia zachowanie zapisu.
"	fileencodings różni się od fileencoding tym, że ustawia domyślny zapis dla wszystkich plików.
"
"-------------------------------------------------------------------------------
"  SPELL
"-------------------------------------------------------------------------------
"
"set spell_executable="aspell"
set spelllang=pl,en
"Rodzaj słownika
"set spell_guess_language_ft="tex,mail,html" 
"Dla jakich typów od razu sprawdzać piswonię
"set spell_auto_type="tex,html,htm,php,sgml,otl,cvs,mail,none"
"Sprawdzanie pisowni w locie
"set spell_insert_mode=1
" vimspell
"let spell_auto_type=""
"
"-------------------------------------------------------------------------------
" HIGHLIGHT & COLORSCHEME
"-------------------------------------------------------------------------------
"
let c_comment_strings=1                         " highlight strings inside C comments
colorscheme torte
"set background=dark
"highlight MatchParen ctermbg=blue guibg=lightyellow " highlight paired brackets
"-------------------------------------------------------------------------------
""highlight SpellErrors ctermfg=Red ctermbg=White guifg=Red guibg=White cterm=underline gui=underline term=reverse
"highlight Normal         ctermfg=LightGrey guibg=black guifg=#AFABAF
"highlight Search         ctermfg=Yellow ctermbg=Red cterm=bold guifg=Yellow guibg=Red
"highlight IncSearch      ctermbg=red ctermfg=black cterm=NONE guifg=red guibg=black
"highlight Visual         cterm=reverse guifg=#303030 guibg=LightGray
"highlight Cursor         ctermfg=Black ctermbg=Green cterm=bold guifg=black guibg=#61FFCF
"highlight Special        ctermfg=Brown guifg=#CF7520
"highlight Comment        ctermfg=LightGray guifg=#7A90FF guibg=black gui=NONE
"highlight StatusLine     cterm=bold gui=NONE ctermfg=green ctermbg=blue guifg=green guibg=#0000AF
"highlight StatusLineNC   ctermfg=black ctermbg=white cterm=NONE
"highlight User1          ctermfg=grey ctermbg=blue cterm=bold
"highlight VertSplit      ctermfg=gray ctermbg=blue cterm=bold
"highlight Statement      ctermfg=Yellow cterm=bold gui=none guifg=Yellow
"highlight vimCommand     ctermfg=Yellow ctermbg=black cterm=NONE guifg=#CF7520
"highlight Type           cterm=NONE gui=NONE guifg=#00AB00
"highlight Identifier     cterm=NONE ctermfg=blue
"highlight NonText        guifg=#7A90FF
"highlight Folded         term=standout cterm=bold ctermfg=6 ctermbg=0 guifg=Cyan guibg=black
"highlight PreProc        term=underline cterm=bold ctermfg=Blue guifg=#7A90FF
"highlight Todo           term=standout ctermfg=0 ctermbg=3 guifg=black guibg=#CF7520
"
"===================================================================================
" BUFFERS, WINDOWS
"===================================================================================
"
"-------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufEnter * :lchdir %:p:h
endif
"
"-------------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif 
"
"-------------------------------------------------------------------------------
" Szybsza obsługa dużych plików
"-------------------------------------------------------------------------------
let g:DuzyPlik = 10 "MB
let g:DuzyPlik = g:DuzyPlik * 1024 * 1024
augroup DuzyPlik
   autocmd BufReadPre * let f=expand("<afile>") |
      \ if getfsize(f) > g:DuzyPlik | set eventignore+=FileType |
      \ setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
      \ else | set eventignore-=FileType | endif
augroup END
"
"===================================================================================
" VARIOUS VARIABLES
"===================================================================================
"
" Przy eksportowaniu pliku jako html używaj css
let g:html_use_css = "1"
let g:use_xhtml = 1000
"
"===================================================================================
" VARIOUS PLUGIN CONFIGURATIONS
"===================================================================================
"
"-------------------------------------------------------------------------------
" perl-support.vim
"-------------------------------------------------------------------------------
"let g:Perl_TemplateOverwrittenMsg= 'no'
let g:Perl_PerlcriticSeverity = 5
let g:Perl_PerlcriticVerbosity = 9
" sprawdzanie składni pod
let g:Perl_PodcheckerWarnings = 'yes'
"let g:Perldoc_path = '$HOME/bin/skrypty/moje/man1'
"
"-------------------------------------------------------------------------------
" bash-support
"-------------------------------------------------------------------------------
"let g:BASH_TemplateOverwrittenMsg = 'no'
"
"-------------------------------------------------------------------------------
" c-support
"-------------------------------------------------------------------------------
"let g:C_TemplateOverwrittenMsg= 'no'
"
"-------------------------------------------------------------------------------
" lattex-support
"-------------------------------------------------------------------------------
let tlist_bib_settings   = 'bib;e:BibTeX-Entries;s:BibTeX-Strings'
let tlist_make_settings  = 'make;m:makros;t:targets'
let tlist_tex_settings   = 'latex;s:Contents;g:Graphics;i:Listings;l:\label;r:\ref;p:\pageref;b:\bibitem'

let s:LATEX_pdf_viewer         = "evince"
"
"-------------------------------------------------------------------------------
" supertab
"-------------------------------------------------------------------------------
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "<c-p>"
let g:SuperTabMappingForward  = '<tab>'
"let g:SuperTabMappingBackward = '<s-tab>'
"
"-------------------------------------------------------------------------------
" file_templates
"-------------------------------------------------------------------------------
let g:file_template_default = "def/PKGBUILD"
let g:VIMFILESDIR = "$HOME/.vim/"
"
"-------------------------------------------------------------------------------
" plugin taglist.vim : toggle the taglist window
" plugin taglist.vim : define the tag file entry for Perl
"-------------------------------------------------------------------------------
"otwiera drugie okienko (split) z funkcjami z pliku
 noremap <silent> <F11>       :TlistToggle<CR>
inoremap <silent> <F11>  <C-C>:TlistToggle<CR>
"
let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD;k:comments'
"
"-------------------------------------------------------------------------------
" manpageview
"-------------------------------------------------------------------------------
"runtime! ftplugin/man.vim
"runtime! plugin/genutils.vim

" vbookmark
let g:vbookmark_bookmarkSaveFile = $HOME . '/.vimbookmark'
" podświetlaj linię pod kursorem
nnoremap <Leader>c :set cursorline!<CR>

" vim-session
let g:session_autosave = 'no'

" pathogen
call pathogen#infect()

" noremap <silent> <C-S-A>:call CopyAll()<CR> 
