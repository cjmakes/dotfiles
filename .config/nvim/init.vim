set termguicolors

filetype plugin indent on
syntax on
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%81v.\+/

set number
set ruler
let mapleader=","

command! Scratch lua require'tools'.makeScratch()

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

" Highlight search results
set hlsearch
set clipboard+=unnamedplus

" Install vimplug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


let g:pymode_python = 'python3'

" Find plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Code completeion engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
imap <C-j> <Plug>(coc-snippets-expand-jump)

Plug 'neoclide/coc-snippets'
Plug 'josa42/coc-go'
Plug 'fatih/vim-go'
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 1
Plug 'neoclide/coc-python'
Plug 'fannheyward/coc-rust-analyzer'

" fzf fuzzy finding
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf' " Need fzf installed
map <C-f> :Files<CR>
map <C-c> :Commits<CR>
nnoremap <silent> <Leader>, :Buffers<CR>
nnoremap <silent> <Leader>/ :History/<CR>
nnoremap <silent> <Leader><Space> :Lines<CR>

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

" Color schemes
Plug 'ajmwagar/vim-deus'
Plug 'vim-scripts/oceanlight'

call plug#end()

 colorscheme deus
"colorscheme oceanlight

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>r  :<C-u>coc-references<cr>
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" Command to store link to current line in bitbucket UI in the system's
" clipboard.
map <leader>b :call <SID>GetSourceLink()<CR>
function <SID>GetSourceLink() range
  let giturls={'git@stash.cfops.it:7999': 'bitbucket.cfdata.org/projects', 'git@bitbucket.cfdata.org:7999': 'bitbucket.cfdata.org/projects', 'git.kernel.org': "elixir.bootlin.com", "github.com": "github.com"}
  let remote=system("git remote get-url origin")
  let commit=system("git rev-parse HEAD")[-1] " remove new line
  let domain=split(remote, '/')[2]
  let project=split(remote, '/')[-2]
  let repo=split(split(remote, '/')[-1], '\.')[0]
  if domain ==# "git.kernel.org" 
    let @+=join(["https:/", giturls[domain], "linux/latest/source" , @%.'#L'.line('.')], "/")
  elseif domain ==# "github.com"
    let @+=join(["https:/", giturls[domain], project, repo, "tree/master", commit, @%.'#L'.a:firstline.'-'.'L'.a:lastline], "/")
  else " bitbucket
    let @+=join(["https:/", giturls[domain], project, "repos", repo ,"browse", @%.'?at='.commit.'#'.a:firstline.'-'.a:lastline], "/")
  endif
endfunction

" Mark a task as done
nnoremap td :s/\[ \]/\=strftime('%Y-%m-%d')/<esc>:noh<cr>ddGpgg

" Insert current date as header
nnoremap cdh "=strftime('%Y-%m-%d')<cr>PI# <esc>j
" Insert current date
nnoremap cd "=strftime('%Y-%m-%d')<cr>P
" Insert current date
nnoremap ct "=printf("%s - ",strftime('%H:%M'))<cr>PA
