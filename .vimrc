execute pathogen#infect()

syntax enable

" Use spaces instead of tabs
set expandtab
"
" Use 'true' colors
set termguicolors

" 1 tab == 4 spaces
set shiftwidth=2
set softtabstop=2
"
" disable mouse
set mouse=

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

" Set the redrawtime to be higher
set redrawtime=10000

" Use a shorter updatetime
set updatetime=300

" Remap : to ;
nnoremap ; :

" User defined commands to toggle line numbers
command NN set nu! | set rnu!
command NU set nu | set rnu

command CHARS set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣ | set list


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
:let g:ctrlp_max_files=0
:let g:ctrlp_custom_ignore='\.git/*\|tmp/*\|test_data/*\|test_fixtures/*\|node_modules/*\|etc/*\|db/*\|spec/integration/*\|spec/unit/*\|spec/factories/*\|spec/smoke/*\|spec/data_source_factories/*\|spec/acceptance/*\|spec/fixtures/*\|certs/*\|public/*\|vendor/*\|staging_fixtures/*\|test_data_population/*\|log/*\|regression_tests/*\|bin/*\'

" ---------------- git-blame specific aliases and functions ---------------------------
:nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" Setup configuration for ruby language server
set shortmess-=F
let g:LanguageClient_serverCommands = {
    \ 'ruby': ['~/.asdf/shims/solargraph', 'stdio'],
    \ }

set hidden
" configuration for coc.vim autocompletion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gcd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
