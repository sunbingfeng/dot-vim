" Set custom map leader ----------------------{{{
let mapleader=","
" }}}

" Vim Basic settings ----------------------------{{{
" helper function to edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

set nocompatible
set updatetime=100
inoremap jk <Esc>
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
set nonumber
set hlsearch incsearch

nnoremap <leader>cc :let @/=''<CR>
" }}}

" Vimscript file folding settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" VIM Plug global configuration -------------{{{
"
let g:plug_url_format = 'git@github.com:%s.git'
" }}}

" Specify all plugins -----------------{{{
call plug#begin('~/.vim/plugged')

" Nerdtree
Plug 'preservim/nerdtree'

" Clang formating
Plug 'rhysd/vim-clang-format'
Plug 'vim-autoformat/vim-autoformat'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

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

" tags
Plug 'yegappan/taglist'
Plug 'craigemery/vim-autotag'

" colorschemes
Plug 'sainnhe/sonokai'
Plug 'tomasr/molokai'

" Doxygen
Plug 'vim-scripts/DoxygenToolkit.vim'

Plug 'mg979/vim-visual-multi'

" commenter
Plug 'tpope/vim-commentary'

" pair operations
Plug 'tpope/vim-surround'

" auto-pairs
Plug 'jiangmiao/auto-pairs'

" git version control
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" markdown support
Plug 'godlygeek/tabular'
"Plug 'preservim/vim-markdown'

" c/cpp source/header switch
Plug 'kuznetsss/shswitch'

Plug 'easymotion/vim-easymotion'

Plug 'nanotee/zoxide.vim'

" Initialize plugin system
call plug#end()
""" }}}

" fzf settings --------------------- {{{
nnoremap <C-g> :RG<Cr>
nnoremap <C-e> :SCW<Cr>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :BTags<CR>
nnoremap <silent> <Leader><C-r> :Tags<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
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

function! RipgrepFzf(query, fullscreen)
  let command_fmt = "rg --ignore-file '/home/bill/.config/rg/.ignore' --column --line-number --no-heading --color=always --smart-case -- %s || true"
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
command! -nargs=* -bang SCW call RipgrepFzf(expand('<cword>'), <bang>0)

" Open files in horizontal split
nnoremap <silent> <Leader>s :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>

" Open files in vertical split
nnoremap <silent> <Leader>v :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>
" }}}

" Git shortcuts --{{{
nnoremap <silent> <Leader>gc :Commits<CR>
nnoremap <silent> <Leader>gb :Git blame<CR>
nnoremap <silent> <Leader>gs :GFiles?<CR>
" }}}
 
" NerdTree settings --{{{
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>- :split<cr>
noremap <Leader>\| :vsplit<cr>
nnoremap <silent> <Leader>f :NERDTreeFind<CR>
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
" }}}

" Bookmarks settings ----------------------{{{
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
" }}}

" YCM settings ---------------{{{
set encoding=utf-8
nnoremap <Leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
" }}}

" tags{{{
nnoremap gd g]
let Tlist_Close_On_Select = 1
let Tlist_Exit_OnlyWindow = 1

let g:autotagCtagsCmd = "ctags --exclude='*.txt'"
let g:autotagExcludeSuffixes = "txt,lua,md,py"

"}}}

" colorscheme --------------------{{{
set guifont=Monaco:h20
set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
set cpoptions+=$ " puts a $ marker for the end of words/lines in cw/c$ commands
" }}}

" multi-cursors ---------{{{
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-n>'
let g:VM_maps['Find Subword Under'] = '<C-n>'
let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'
let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'
" select all occurences in of that selection
nmap <C-a> <Plug>(VM-Select-All)
imap <C-a> <ESC><Plug>(VM-Select-All)
vmap <C-a> <ESC><Plug>(VM-Select-All)

autocmd BufWrite * try | call vm#reset() | catch | endtry
" }}}

" Code Formatting -------------{{{
" noremap <Leader>cs :ClangFormat<CR>
let g:formatters_python = ['yapf']
let g:formatterpath = ['/home/bill/.local/bin']
" }}}

" Jumps ---------------------{{{
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction
nmap <Leader>j :call GotoJump()<CR>
noremap <Leader>jf <c-i> 
noremap <Leader>jb <c-o> 

" Quick navigate between different projects.
" It depends on the 'zoxide.vim' package
nnoremap <silent> <Leader>w :Zi<CR>
" }}}

" Others----------------------{{{
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
"}}}
