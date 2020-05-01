set termguicolors

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

" Folding config
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

" Esc in Terminal
tnoremap <Esc> <C-\><C-n>

" Bind function keys to rerun last command in the terminal they were bound to
map <leader-F5> map <F5> :call jobsend(b:terminal_job_id, "!!\n\n")<CR>

filetype plugin indent on
syntax on

" Highlight search results
set hlsearch
set clipboard+=unnamedplus



" Install vimplug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Find plugins
call plug#begin(stdpath('data') . '/plugged')

" Code completeion engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-snippets'
imap <C-j> <Plug>(coc-snippets-expand-jump)
Plug 'honza/vim-snippets'

Plug 'neoclide/coc-rls'
Plug 'josa42/coc-go'
Plug 'neoclide/coc-python'
Plug 'clangd/coc-clangd'


" fzf fuzzy finding
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf' " Need fzf installed
map <C-f> :Files<CR>
map <C-c> :Commits<CR>
nnoremap <silent> <Leader>, :Buffers<CR>
nnoremap <silent> <Leader>/ :History/<CR>
nnoremap <silent> <Leader><Space> :Lines<CR>

" Color schemes
Plug 'ajmwagar/vim-deus'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" Netrw is cool, but not very comfortable
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

Plug 'scrooloose/nerdcommenter'

call plug#end()

colorscheme deus
