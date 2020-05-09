"Rebecca's vimrc

"
"System
"
set encoding=utf-8

let mapleader = "\<Space>"	" Set leader to the spacebar

set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50							"the last 50 commands
set autowrite     					"Automatically :write before running commands
set modelines=0   					"Disable modelines as a security precaution
set nomodeline

"Stupid lazy-shift holding errors
cnoremap W w
cnoremap WQ wq
cnoremap wQ wq
cnoremap Q q

"Set spell check for text files
autocmd FileType gitcommit,mail,mkd,text set spell

"prevent vim from backing up crontabs
set backupskip=/tmp/*,/private/tmp/*

"
"Plugins!
"
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif


"
"Display
"
set background=dark			"Set colorscheme
colorscheme solarized
set guifont=Menlo:h20		"Set font and size

set nowrap							"Set no word wrap
set number							"Set line numbers
set cursorline					"Highlight the cursor line

set textwidth=80				" Make it obvious where 80 characters is
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

set splitbelow					"New split panes open to right and to bottom
set splitright

"Set syntax highlighting for specific file types
augroup vimrcEx
  autocmd!

  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
  autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
  autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
  autocmd BufRead,BufNewFile vimrc.local set filetype=vim
augroup END

" Status line
set showmode						"Show the mode
set ruler								"Show column and line number at bottom right
set wildmenu						"Get the nice tab through menu
set laststatus=2 				"Always show status line
set statusline=%f 			"Path to the file
set statusline+=%= 			"Switch to the right side
set statusline+=%l 			"Current line
set statusline+=/ 			"Separator
set statusline+=%L 			"Total lines


"
"Searching
"
set showmatch 					" Show matching brackets and parentheses
set hlsearch						" Highlight search terms
set ignorecase					" Ignore case in search
set incsearch						" find as you type search
"Make search always go the same direction
noremap <silent> n /<CR>
noremap <silent> N ?<CR>


"
"Key remaps
"
inoremap jk <esc>		" Map 'jk' to escape
" Make j,k,0,and $ behave the same way with wrapped lines
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

"Double tap space to comment
map <leader><leader> <plug>NERDCommenterToggle

"Copy-paste
xnoremap p pgvy			" Allow for pasting multiple lines
"Copy and paste to system clipboard with space y and space d
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

vnoremap <tab> >gv "Indent visual mode selection with tab
vnoremap <s-tab> <gv "Unindent visual mode selection with shift-tab

"Code folding key mappings
"ff creates a fold
"fa toggles a fold, fc closes, fo opens
set foldenable
set foldmethod=manual
vnoremap ff zf
nnoremap fa za
vnoremap fc zc
vnoremap fo zo

" Move between linting errors
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>


"
"Editing
"
set autoindent		" Copy indent from current line when starting a new line
set expandtab			" Tab to spaces
set tabstop=4			" Tab is default 4 spaces
set softtabstop=0
set shiftwidth=4
set smarttab
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces



"
"Plugin config
"
"Nerd tree
noremap \ :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Delimitmate
let delimitMate_matchpairs = "(:),[:],{:}"

" ALE linting events
augroup ale
  autocmd!

  if g:has_async
    autocmd VimEnter *
      \ set updatetime=1000 |
      \ let g:ale_lint_on_text_changed = 0
    autocmd CursorHold * call ale#Queue(0)
    autocmd CursorHoldI * call ale#Queue(0)
    autocmd InsertEnter * call ale#Queue(0)
    autocmd InsertLeave * call ale#Queue(0)
  else
    echoerr "The thoughtbot dotfiles require NeoVim or Vim 8"
  endif
augroup END


"
"Source local .vimrc
"
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
