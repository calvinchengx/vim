" My personalized vimrc file.
"
" Maintainer calvin@calvinx.com
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

call pathogen#infect()

" Powerful omnicompletion/keyword completion based on context
let g:SuperTabDefaultCompletionType = "context"
" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" set your colorscheme. 
if &diff
    set background=dark
    colorscheme peaksea
else
    colorscheme elflord
endif

" This caters for the scenario when vimdiff is called while inside a vim buffer
au FilterWritePost * if &diff | set bg=dark | colorscheme peaksea | else | colorscheme elflord | endif
au BufWinLeave * colorscheme elflord

"colorscheme mustang
"colorscheme zenburn
"colorscheme elflord
"colorscheme django
"colorscheme blacklight
"colorscheme wombat
"colorscheme zellner
"colorscheme evening
"colorscheme torte
"colorscheme pablo
"set transparency=25

" vimdiff color scheme
"highlight DiffChange cterm=none ctermfg=black ctermbg=LightGreen gui=none guifg=bg guibg=LightGreen
"highlight DiffText cterm=none ctermfg=black ctermbg=Red gui=none guifg=bg guibg=Red

filetype plugin on

set nofoldenable
"set foldmethod=indent
"set foldlevel=99
"set foldnestmax=2

set clipboard=unnamed
set title
" These two lines are not portable on linux
" set lines=999
" set columns=999
set go-=T
" small hack
set guioptions+=lrb
set guioptions-=lrb
set number
" END gVim settings

" MacVim settings

" End MacVim settings
"

" set swapfile
" set dir=~/tmp
" set backupdir=~/tmp

if $VIM_CRONTAB == "true"
	set nobackup
	set nowritebackup
endif

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings much better!.
" This must be first, because it changes other options as a side effect.
"set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set nobackup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
"set autochdir

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Mac customizations 
let mapleader = ","

if has("gui_running")
	set guitablabel=%t%=%m  "Set the label of the tabs
	set nomacatsui anti enc=utf-8 tenc=macroman gfn=Monaco:h11
	" set window size
	set lines=40
	set columns=120
else
	"set enc=utf-8 tenc=macroman gfn=Monaco:h11
	set enc=utf-8 tenc=utf-8 gfn=Monaco:h11
	set fenc=utf-8
endif

"nmap <C><Up> :tabnew<CR>
"nmap <leader><Up> :tabnew<CR>
"nmap <leader><Down> :tabclose<CR>
"nmap <leader><Left> gT<CR>
"nmap <leader><Right> gt<CR>
"map Apple-t to new tab  
"nmap <M-t> :tabnew<CR>
"inoremap <D-Up> <C-O>:tabnew<CR>
"nnoremap <D-Up> :tabnew<CR>
"onoremap <D-Up> <C-C>:tabnew<CR>
"vnoremap <D-Up> :tabnew<CR>
"Map Apple-w to close tab 
"inoremap <D-w> <C-O>:tabclose<cr>
"nnoremap <D-w> :tabclose<CR>
"onoremap <D-w> <C-C>:tabclose<CR>
"vnoremap <D-w> :tabclose<CR>
"map Apple-Up to previous tab 
"nnoremap <D-Up> gT
"vnoremap <D-Up> gT
"inoremap <D-Up> <C-O>gT
"onoremap <D-Up> <C-C>gT
"map Apple-Down to next tab  
"nnoremap <D-Down> gt
"vnoremap <D-Down> gt
"inoremap <D-Down> <C-O>gt
"onoremap <D-Down> <C-C>gt

au BufNewFile,BufRead *.map setf map
au BufNewFile,BufRead *.ini,*/.hgrc,*/.hg/hgrc setf ini 

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" In many terminal emulators the mouse works just fine, thus enable it.
	set mouse=r

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		autocmd BufReadPost *
					\ if line("'\"") > 0 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END

	" Drupal PHP files with strange extensions
	augroup drupal
		autocmd BufNewFile,BufRead *.module set filetype=php
		autocmd BufNewFile,BufRead *.engine set filetype=php
	augroup END

	" flex
	au BufNewFile,BufRead *.mxml set filetype=mxml
	au BufNewFile,BufRead *.as set filetype=actionscript

	au BufNewFile,BufRead *.py set filetype=python


	" autoclose tags
	" use ctrl-_ to close the last opened tag
	" au Filetype html,xml,xsl source ~/.vim/plugin/closetag/closetag.vim 

	" htmldjango
	au FileType htmldjango setlocal shiftwidth=4
	au FileType htmldjango setlocal tabstop=4
	au FileType htmldjango setlocal softtabstop=4
	au FileType htmldjango setlocal expandtab

	" crontab
	au FileType crontab set nobackup nowritebackup

	" ragtag, quick inserting for tags
	let g:allml_global_maps = 1 

	"autocompletion for basic languages
	autocmd FileType python set omnifunc=pythoncomplete#Complete
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
	autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
	autocmd FileType php set omnifunc=phpcomplete#CompletePHP
	autocmd FileType c set omnifunc=ccomplete#Complete

	" Convenient command to see the difference between the current buffer and the
	" file it was loaded from, thus the changes you made.
	 "command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis 
				 "\ | wincmd p | diffthis

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" tell gnome terminal that 256 colors work
set t_Co=256
" show line numbers
"set nu


"
" Keyboard mappings
"
""""""""""""""""""""

" insert blank line and return to normal mode
map zj o<Esc>
map zk O<Esc>

"map <C-Down> :tabclose<CR>
"map <C-Down> :q<CR>
"map <C-Left> gT
"map <C-Right> gt
"map <C-t> :tabnew<CR>
"map <C-w> :tabclose<CR>
"map <C-[> gT<CR>
"map <C-]> gt<CR>

"map file save
" in various scenarios, some weird
map <F2> :w<CR>
map <C-s> :w<CR>
imap jj <Esc>:w<CR>

" disable and enable highlights
map <D-j> :nohlsearch<CR>
map <D-J> :set hlsearch<CR>

"map browse files
map <F2> :NERDTreeToggle<CR>:set encoding=utf-8<CR>
map <F3> :o .<CR>
map <F4> :Ex <CR>
map <F5> :nohl <CR>
map <F6> :rightbelow vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map <F7> :NERDTreeClose<CR>

"show hidden files in nerdtree
let NERDTreeShowHidden=1
let NERDTreeDirArrows=0

"NERDTree customization
let NERDTreeMapOpenInTab='<tab>t'

"Django
"for templates
imap {{     {{ }}<Esc>hhi
imap {%     {% %}<Esc>hhi
imap {#     {# #}<Esc>hhi
" type table,,, to get <table></table>       ### Cool ###
imap ,,, <esc>bdwa<<esc>pa><cr></<esc>pa><esc>kA

""" Maps to opening main Django files 
map mo /models.py<CR><CR>
map rl /urls.py<CR><CR>
map vi /views.py<CR><CR>
map fo /forms.py<CR><CR>
map tp /templates<CR><CR>
map ad /admin.py<CR><CR>
map til /utils.py<CR><CR>

" map for JS/PHP long comments used 
" mainly for function descriptions
map <C-c> i/*<CR>*/

""" Maps for tap navigation
"map <C-t> :tabnew<CR>
"map <C-w> :tabclose<CR>

set statusline=%{fugitive#statusline()}\ m%F%r%h%w\ %y\ [line:%04l\ col:%04v]\ [%p%%]\ [lines:%L]
set laststatus=2
set shiftwidth=4
set ic
set scs
set tabstop=4
set autoread
set tags=./tags,$VIRTUAL_ENV/tags;/
set binary
if has("multi_byte")
  if &termencoding == ""
	let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

" put some quick abbreviations
ab javoid href="javascript:void(0);"
ab jaclick onclick="javascript:"
ab br <br />
ab _get $_GET['']
ab _post $_POST['']
ab sefl self

" python settings
autocmd BufRead *.py setlocal shiftwidth=4
autocmd BufRead *.py setlocal tabstop=4
autocmd BufRead *.py setlocal softtabstop=4
autocmd BufRead *.py setlocal expandtab

map ,sh :source ~/.vim/vimsh.vim<CR>
map ,shpy :source ~/.vim/vimsh.vim

command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
	" Building a hash ensures we get each buffer only once
	let buffer_numbers = {}
	for quickfix_item in getqflist()
		let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
	endfor
	return join(values(buffer_numbers))
endfunction

map <leader>b :ls<CR>:b

" python/django unit tests
let g:makeprg_django_app = 'python\ manage.py\ test\ -v\ 0'
let g:makeprg_django_project = 'python\ manage.py\ test'
set errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

function! RunTestsForFile(args)
    if @% =~ '\.py$'
        let expandstr = '%:p:h' " dirname
        while expand(expandstr) != '/'
            let testpath = expand(expandstr)
            if len(getfperm(testpath . '/tests')) > 0 || len(getfperm(testpath . '/tests.py')) > 0
                call RunTests(expand(expandstr . ':t'), a:args)
                return
            endif
            let expandstr .= ':h'
        endwhile
    endif
    call RunTests('', a:args)
endfunction

function! RunTests(target, args)
    silent ! echo
    silent ! echo -e "\033[1;36mRunning all unit tests\033[0m"
    silent w
    if len(a:target)
        execute 'set makeprg=' . g:makeprg_django_app
    else
        execute 'set makeprg=' . g:makeprg_django_project
    endif
    exec "make! " . a:target . " " . a:args
endfunction

function! JumpToError()
    let has_valid_error = 0
    for error in getqflist()
        if error['valid']
            let has_valid_error = 1
            break
        endif
    endfor
    if has_valid_error
        for error in getqflist()
            if error['valid']
                break
            endif
        endfor
        let error_message = substitute(error['text'], '^ *', '', 'g')
        silent cc!
        exec ":sbuffer " . error['bufnr']
        call RedBar()
        echo error_message
    else
        call GreenBar()
        echo "All tests passed"
    endif
endfunction

function! RedBar()
    hi RedBar ctermfg=white ctermbg=red guibg=red
    echohl RedBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction

function! GreenBar()
    hi GreenBar ctermfg=white ctermbg=green guibg=green
    echohl GreenBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction

nnoremap <leader>a :call RunTests('', '')<cr>:redraw<cr>:call JumpToError()<cr>
nnoremap <leader>y :call RunTestsForFile('--failfast')<cr>:redraw<cr>:call JumpToError()<cr>

" syntastic.vim plugin settings
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_python_checker_args='--ignore=E501'

" syntastic.vim plugin includes pylint
let g:pymode_lint_ignore = "W404,E501"

" javascript-libraries-syntax.vim plugin
let g:used_javascript_libs = 'angularjs'

" Customize jshint highlights 
hi clear SpellBad
hi SpellBad cterm=underline,bold ctermfg=white ctermbg=DarkRed
