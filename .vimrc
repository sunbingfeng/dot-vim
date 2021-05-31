set nocompatible

let mapleader=","

" Vim Basic settings
set updatetime=100
imap jk <Esc>
vnoremap g/ y/<C-R>"<CR>
map <C-s> :w<CR>
syntax enable
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Nerdtree
Plug 'preservim/nerdtree'

" Clang formating
Plug 'rhysd/vim-clang-format'
Plug 'Chiel92/vim-autoformat'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Bookdmark manager
Plug 'mattesgroeger/vim-bookmarks'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

Plug 'ycm-core/YouCompleteMe', {'branch': 'legacy-c++11', 'do': function('BuildYCM') }

" taglist
Plug 'yegappan/taglist'

" colorschemes
Plug 'sainnhe/sonokai'
Plug 'tomasr/molokai'

" Doxygen
" Plug 'DoxygenTookit.vim'

Plug 'mg979/vim-visual-multi'

" markdown support
Plug 'suan/vim-instant-markdown'

" commenter
Plug 'tpope/vim-commentary'

" pair operations
Plug 'tpope/vim-surround'

" auto-pairs
Plug 'jiangmiao/auto-pairs'

" git version control
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

" fzf settings
nnoremap <C-g> :Rg<Cr>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :BTags<CR>
nnoremap <silent> <Leader><C-r> :Tags<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R --exclude=.git'"

" NerdTree settings
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>- :split<cr>
noremap <Leader>\| :vsplit<cr>
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
nnoremap <silent> <Leader>tn :tabn<CR>
nnoremap <silent> <Leader>tp :tabn<CR>
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

let NERDTreeQuitOnOpen = 1
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Bookmarks settings
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

" YCM settings
nnoremap <Leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1

" tags
nnoremap gd g]
let Tlist_Close_On_Select = 1
let Tlist_Exit_OnlyWindow = 1

" colorscheme
color molokai
set guifont=Monaco:h20
set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
" autocmd User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
:set cpoptions+=$ " puts a $ marker for the end of words/lines in cw/c$ commands

" multi-cursors
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-n>'
let g:VM_maps['Find Subword Under'] = '<C-n>'
let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'
let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'


" auto-pairs
"let g:AutoPairsShortcutJump = '<C-Space>'

" gitgutter
