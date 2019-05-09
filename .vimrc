execute pathogen#infect()

syntax enable

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=2
set softtabstop=2

" Show 3 lines above/below cursor
set scrolloff=3

" Show line numbers
set number

" Autoindent code
set autoindent

" Ignore case when searching
set ignorecase

" Be smart about case when searching
set smartcase

" Turn magic on for regex
set magic
set t_Co=256

" Set size of windows
set wmh=0
set wiw=85

" Better movement between windows
map <c-h> <c-w>h<c-w>_
map <c-l> <c-w>l<c-w>_

" Default color scheme
colo desert

" Set line number colors
:highlight LineNr ctermfg=gray 

" Turn off
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Remap escape key to jk
imap jk <Esc>

" Show relative line numbers
set rnu

" Highlight search results
set hlsearch
set backspace=2

" Always show current position
set ruler

" Don't wrap lines by default
set nowrap

" Always show status line
set laststatus=2
set statusline=\%{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\:%c

" Use the cursorline and set the color
set cursorline
hi Cursorline cterm=None ctermbg=235 ctermfg=None


" Return to last edit position when opening files
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

" Delete trailing whitespace on save for python files
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

" Set tab width to 4 for .go files and don't expand tabs to spaces
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Convert slashes to backslashes for Windows.
if has('win32')
  nmap ,cs :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap ,cl :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap ,c8 :let @*=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap ,cs :let @*=expand("%")<CR>
  nmap ,cl :let @*=expand("%:p")<CR>
endif

" ---------------- NERDTree specific aliases and functions --------------------

" Remap NERDTree to \v and open on the current file
:nnoremap <silent> <Leader>v :NERDTreeFind<CR>

" Set options for NERDTree UI
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" ---------------- Ack specific aliases and functions ---------------------------
:nnoremap <leader>a :Ack<Space>

" ---------------- ctrlp specific aliases and functions ---------------------------
:let g:ctrlp_max_files=20000
:let g:ctrlp_custom_ignore='\.git/*\|tmp/*\|test_data/*\|test_fixtures/*\|node_modules/*\|etc/*\|db/*\|*.haml\|*.html'

" ---------------- git-blame specific aliases and functions ---------------------------
:nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>
