syntax enable
set expandtab
set shiftwidth=4
set softtabstop=4
set scrolloff=3
set number
set autoindent
set ignorecase
set smartcase
set magic
set t_Co=256
set wmh=0
set wiw=85
map <c-h> <c-w>h<c-w>_
map <c-l> <c-w>l<c-w>_
colo desert
:highlight LineNr ctermfg=gray 
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
imap jk <Esc>
set rnu
set hlsearch
set backspace=2
set ruler
set nowrap
set laststatus=2
set cursorline
hi Cursorline cterm=None ctermbg=235 ctermfg=None

" Set tab width to 4 for .go files and don't expand tabs to spaces
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
