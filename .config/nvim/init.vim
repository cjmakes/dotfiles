" Install vimplug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Find plugins
call plug#begin(stdpath('data') . '/plugged')

" Autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
" Close function preview window
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Linting
Plug 'w0rp/ale'

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

let g:neosnippet#enable_completed_snippet = 1

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

Plug 'zchee/deoplete-clang'

" Go Formatting & Autocomplete
Plug 'zchee/deoplete-go', { 'do': 'make' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
let g:go_metalinter_autosave = 1
" Auto import go packages
let g:go_fmt_command = "goimports"
" Get type info of go variable
autocmd FileType go nnoremap <buffer> <leader>t :GoInfo<CR>

" Python Autocomplete
Plug 'zchee/deoplete-jedi'

" fzf fuzzy finding
Plug 'junegunn/fzf.vim'
" Need fzf installed
Plug '/usr/local/opt/fzf'
nnoremap <silent> <Leader>, :Buffers<CR>
nnoremap <silent> <Leader>/ :History/<CR>
nnoremap <silent> <Leader><Space> :Lines<CR><Paste>

" Color schemes
Plug 'ajmwagar/vim-deus'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
" Close vim if NERDTree is the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

Plug 'scrooloose/nerdcommenter' 

Plug 'tpope/vim-surround'

call plug#end()


set termguicolors
colorscheme deus

highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%81v.\+/

set number
set ruler
let mapleader=","

" Spaces > Tabs
set tabstop=2
set shiftwidth=2
set expandtab

set autoindent
set copyindent
set shiftround
set spell spelllang=en_us
set spell!
set backspace=2 " make backspace work like most other programs
set history=1000
set undolevels=1000

" Vertical line at 81, dark after 120
let &colorcolumn=join(range(81,999),",")
let &colorcolumn="80,".join(range(120,999),",")

" Moving between panes should be easy
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" wtf does ; do? use it as : instead
nnoremap ; :

" Visual moves
nnoremap j gj
nnoremap k gk

" FZF Binds
map <C-f> :Files<CR>
map <C-c> :Commits<CR>

" Folding config
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Esc in Terminal
tnoremap <Esc> <C-\><C-n>

" Save and restore vim sessions
map <F2> :mksession! ./.vim_session <cr> " Quick write session with F2
map <F3> :source ./.vim_session <cr>     " And load session with F3

" Bind function keys to rerun last command in the terminal they were bound to
map <leader-F5> map <F5> :call jobsend(b:terminal_job_id, "!!\n\n")<CR>

" Fzf for buffers, history, and lines in open buffers
nnoremap <silent> <Leader>, :Buffers<CR>
nnoremap <silent> <Leader>/ :History/<CR>
nnoremap <silent> <Leader><Space> :Lines<CR>

filetype plugin indent on
syntax on

" Highlight search results
set hlsearch
