set nocompatible

set directory=~/.dot/nvim/swap//
set nobackup
set nowritebackup

set shiftwidth=4
set tabstop=4
set et
setlocal cindent
set number

set hidden
set noreadonly
set lazyredraw
set showmode
set path+=**
set wildmode=longest:full
set wildmenu
set ruler
set modeline
syntax on
syntax enable

"================================== Optional ===================================
"set cursorline
"set iskeyword-=_

call plug#begin()
Plug 'bronson/vim-visual-star-search'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'chriskempson/base16-vim'
Plug 'dyng/ctrlsf.vim'
Plug 'Hydrotoast/mrepl.vim'
Plug 'wsdjeg/vim-fetch'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/goyo.vim'
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

colorscheme nord

nnoremap Q <Nop>
nnoremap <F1> :NERDTreeFind<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F5> :checktime<CR>
nnoremap <F6> :Goyo<CR>
nnoremap <F8> :set ignorecase! ignorecase?<CR>
tnoremap <Esc> <C-\><C-n>

let mapleader = "\<SPACE>"

nnoremap <silent> g* :let @/=expand('<cword>') <bar> set hls <cr>

nmap ]e <Plug>(GitGutterNextHunk)
nmap [e <Plug>(GitGutterPrevHunk)

nnoremap <leader>ee :Git<SPACE>

"" NerdTree
"" =============================================================================
:let g:NERDTreeWinSize=60

"" Goyo
"" =============================================================================
let g:goyo_width = '120'
let g:goyo_height = '80%'

" ctrlsf
" =============================================================================
"nmap <leader>ss <Plug>CtrlSFPrompt
vmap <leader>sp <Plug>CtrlSFVwordPath
"vmap <leader>se <Plug>CtrlSFVwordExec
nmap <leader>sp <Plug>CtrlSFCwordPath
"nmap <leader>sf <Plug>CtrlSFPwordPath


" git-blame

nnoremap <Leader>aa :<C-u>call gitblame#echo()<CR>

" gutentags
" =============================================================================

let g:gutentags_add_default_project_roots = 1
"let g:gutentags_project_root = ['.project']
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_cache_dir = expand('~/.cache/tags')
"command! -nargs=0 GutentagsClearCache call system('rm ' . g:gutentags_cache_dir . '/*')

" ctags fields
"    a: Access (or export) of class members
"    i: Inheritance information
"    l: Language of input file containing tag
"    m: Implementation information
"    n: Line number of tag definition
"    S: Signature of routine (e.g. prototype or parameter list)

let g:gutentags_ctags_extra_args = [
			\ '--extra=+fq',
			\ '--c++-kinds=+p',
			\ '--tag-relative=yes',
			\ '--fields=+ailmnS',
			\ ]

let g:gutentags_ctags_exclude = [
			\'target',
			\'node_modules',
			\'bundle.js',
			\'bazel-*',
			\ '*.git', '*.js.map', '.svn', '.hg',
			\'*.min.*', '*.swp', '*.bak', '*.tar.*',
			\'*.tex', '*.css', '*.json', '*.js',
			\'*.html', '*.svg', '*.m', '*.proto',
			\'*.xml', '*.inl', '*.ini', '*.txt',
			\]

"" Vimtex
"" =============================================================================
nnoremap <silent> <leader>tc :VimtexCompile<CR>
nnoremap <silent> <leader>tv :VimtexView<CR>

"" FzF
"" =============================================================================

function! s:tags_sink(line)
	let parts = split(a:line, '\t')
	let excmd = matchstr(parts[2], '^.*\ze;')
	"let excmd = parts[2]
	echom "parts " . string(parts)
	echom "excmd " . string(excmd)
	execute 'silent e' parts[1]
	let [magic, &magic] = [&magic, 0]
	execute excmd
	let &magic = magic
endfunction

function! TagSelectWindow(tag)
        let l:taglist = map(taglist('^' . a:tag . '$'),
                \'v:val["kind"] . "\t" . v:val["filename"] . "\t" . v:val["cmd"]')
        call fzf#run({ 'source' : l:taglist, 'sink' : function('s:tags_sink'),
                \'window' : {'width': 0.9, 'height': 0.8},
		\'options' : '--reverse --bind=tab:down --header=' .
                \ a:tag })
endfunction

nnoremap <silent> <leader>gs :call TagSelectWindow(expand('<cword>'))<CR>

nnoremap <silent> <leader>tt :call fzf#vim#tags(expand('<cword>'))<CR>
nnoremap <silent> <leader>hh :call fzf#vim#history()<CR>
nnoremap <silent> <leader>bb :call fzf#vim#buffers()<CR>
nnoremap <silent> <leader>ll :call fzf#vim#buffer_lines()<CR>
nnoremap <silent> <leader>ff :call fzf#vim#files(".")<CR>
nnoremap <silent> <leader>fa :call fzf#vim#files("application/adp")<CR>

command! -nargs=+ -bang -complete=command FeedForward call fzf#run({
            \ 'source' : filter(split(execute(<q-args>), "\n"), {i,v->!empty(v)}),
            \ 'sink': function('s:ff_sink'),
            \ 'options' : <bang>0 ? '--tac' : ''})

" copy into @@, ignore leading index
function! s:ff_sink(item)
  let text = substitute(a:item, '\v^\>?\s*\d+\:?\s*', '', '')
  let @@ = empty(text) ? a:item : text
endfunction

