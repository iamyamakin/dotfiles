set background=dark
" if filereadable(expand("~/dotfiles/vim/bundle/vim-colors-solarized/colors/solarized.vim"))
"     let g:solarized_termcolors=16
"     let g:solarized_termtrans=1
"     let g:solarized_contrast="high"
"     let g:solarized_visibility="high"
"     colorscheme solarized
" endif
let g:hybrid_custom_term_colors = 1
colorscheme hybrid

let mapleader=","

map <leader>tt :tabnew<cr>
map <leader>te :tabedit<space>
map <leader>tc :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove<space>
set pastetoggle=<leader>p

nnoremap <silent> <space> :nohlsearch<cr>

set ruler
set more
set autoread
set number
set hidden
set lazyredraw
set showmode
set showcmd

set autoindent
set smartindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set shiftround
set copyindent
set preserveindent
set virtualedit=onemore

set scrolloff=5
set sidescrolloff=5
set history=200
set backspace=indent,eol,start
set linebreak
set cmdheight=1
set undolevels=1000
set updatecount=100
set complete=.,w,b,u,U,t,i,d
set ttyfast
set shell=bash
set fileformats=unix

set incsearch
set ignorecase
set showmatch
set smartcase
set hlsearch
set diffopt=filler,iwhite
set gdefault

set title
set visualbell
set noerrorbells

set guicursor=n-v-c:block-Cursor-blinkon0
set guicursor+=ve:ver35-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=i-ci:ver25-Cursor
set guicursor+=r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175

set listchars=tab:▸\.,eol:¬,trail:~
nmap L :set list!<cr>

set wildmode=list:longest
set wildmenu
set wildignore+=.git
set wildignore+=*.DS_Store?

set laststatus=2
set statusline=%<%f\ [%Y%R%W]%1*%{(&modified)?'\ [+]\ ':''}%*%=%c%V,%l\ %P\ [%n]

set encoding=utf-8
set fileencodings=utf-8,cp1251,cp866,koi8-r
set termencoding=utf-8

set nowrap
set textwidth=120
set colorcolumn=+1

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Multiple Cursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<leader>mc'
let g:multi_cursor_next_key='<C-j>'
let g:multi_cursor_prev_key='<C-k>'
let g:multi_cursor_skip_key='<C-h>'
let g:multi_cursor_quit_key='<C-l>'

" NerdTree
map <c-n> :NERDTreeToggle<cr>:NERDTreeMirror<cr>
map <leader>n :NERDTreeFind<cr>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" Ag
if executable('ag')
    noremap <leader>/ :Ag!<space>
    let g:ag_prg="ag --column --hidden --vimgrep"
endif

" Syntastic
let g:syntastic_enable_signs=1

" Airline
if !exists('g:airline_theme')
    let g:airline_theme='hybridline'
endif
if !exists('g:airline_powerline_fonts')
    " Use the default set of separators with a few customizations
    let g:airline_left_sep='›'  " Slightly fancier than '>'
    let g:airline_right_sep='‹' " Slightly fancier than '<'
endif

" Sync
autocmd BufWritePost * :call SyncUploadFile()
autocmd BufReadPre * :call SyncDownloadFile()

" Sideways
nnoremap - :SidewaysLeft<cr>
nnoremap = :SidewaysRight<cr>
nnoremap + :Switch<cr>

" Javascript libs syntax
let g:used_javascript_libs = 'jquery,underscore,backbone,react,flux'
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0

autocmd BufWritePre * :%s/\s\+$//e
