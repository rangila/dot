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

autocmd BufEnter *.rst setlocal shiftwidth=3 tabstop=3

"================================== Optional ===================================
set cursorline
"set iskeyword-=_

call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
call plug#end()
        
"" colorscheme
"" =============================================================================
if has('termguicolors')
"	set termguicolors
endif

set background=dark
"set background=light

" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'hard'

" For better performance
let g:everforest_better_performance = 1

colorscheme everforest

nnoremap Q <Nop>
nnoremap <F1> :NERDTreeFind<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :NERDTreeRefreshRoot<CR>
nnoremap <F5> :checktime<CR>
nnoremap <F6> :Goyo<CR>
nnoremap <F7> :set ignorecase! ignorecase?<CR>
nnoremap <F8> :set background=dark<CR>
nnoremap <F9> :set background=light<CR>
tnoremap <Esc> <C-\><C-n>

let mapleader = "\<SPACE>"

nnoremap <silent> g* :let @/=expand('<cword>') <bar> set hls <cr>

"" wiki.vim
"" =============================================================================
let g:wiki_root = '~/wiki'


"" Git
"" =============================================================================

nmap <leader>en <Plug>(GitGutterNextHunk)
nmap <leader>ep <Plug>(GitGutterPrevHunk)

nnoremap <leader>ee :Git<SPACE>
nnoremap <leader>el :Flog<CR>
nmap <Leader>eb <Plug>(git-messenger)

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

let g:ctrlsf_default_root = 'project'

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
"nnoremap <silent> <leader>hh :call fzf#vim#history()<CR>
nnoremap <silent> <leader>bb :call fzf#vim#buffers()<CR>
nnoremap <silent> <leader>ll :call fzf#vim#buffer_lines()<CR>
nnoremap <silent> <leader>ff :call fzf#vim#files(".")<CR>

command! -nargs=+ -bang -complete=command FeedForward call fzf#run({
            \ 'source' : filter(split(execute(<q-args>), "\n"), {i,v->!empty(v)}),
            \ 'sink': function('s:ff_sink'),
            \ 'options' : <bang>0 ? '--tac' : ''})

" copy into @@, ignore leading index
function! s:ff_sink(item)
  let text = substitute(a:item, '\v^\>?\s*\d+\:?\s*', '', '')
  let @@ = empty(text) ? a:item : text
endfunction

"" FZF MRU
"" =============================================================================

command! -bang -nargs=? FZFMru call fzf_mru#actions#mru(<q-args>,
    \{
        \'window': {'width': 0.9, 'height': 0.8},
        \'options': [
            \'--preview', 'bat --style=numbers --color=always {}',
            \'--preview-window', 'up:60%',
            \'--bind', 'ctrl-_:toggle-preview'
        \]
    \}
\)

nnoremap <silent> <leader>hh :FZFMru<CR>

let g:fzf_mru_relative = 1
let g:fzf_mru_no_sort = 1


"" Emmet
"" =============================================================================

let g:user_emmet_leader_key='<C-S>'
let g:user_emmet_mode='a'


"" clang-format on save
"" =============================================================================
function FormatBufferConditional()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format-15
    call setpos('.', cursor_pos)
  endif
endfunction

function FormatBuffer()
    let cursor_pos = getpos('.')
    :%!clang-format-15
    call setpos('.', cursor_pos)
endfunction

"autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()
nnoremap <silent> <leader>aa :call FormatBuffer()<CR>

"" Telekasten
"" =============================================================================


nnoremap <leader>gg :lua require('telekasten').find_notes()<CR>
nnoremap <leader>gd :lua require('telekasten').find_daily_notes()<CR>
nnoremap <leader>gs :lua require('telekasten').search_notes()<CR>
nnoremap <leader>gf :lua require('telekasten').follow_link()<CR>
nnoremap <leader>gT :lua require('telekasten').goto_today()<CR>
nnoremap <leader>gW :lua require('telekasten').goto_thisweek()<CR>
nnoremap <leader>gw :lua require('telekasten').find_weekly_notes()<CR>
nnoremap <leader>gn :lua require('telekasten').new_note()<CR>
nnoremap <leader>gN :lua require('telekasten').new_templated_note()<CR>
nnoremap <leader>gy :lua require('telekasten').yank_notelink()<CR>
nnoremap <leader>gc :lua require('telekasten').show_calendar()<CR>
nnoremap <leader>gC :CalendarT<CR>
nnoremap <leader>gi :lua require('telekasten').paste_img_and_link()<CR>
nnoremap <leader>gt :lua require('telekasten').toggle_todo()<CR>
nnoremap <leader>gb :lua require('telekasten').show_backlinks()<CR>
nnoremap <leader>gF :lua require('telekasten').find_friends()<CR>
nnoremap <leader>gI :lua require('telekasten').insert_img_link({ i=true })<CR>
nnoremap <leader>gp :lua require('telekasten').preview_img()<CR>
nnoremap <leader>gm :lua require('telekasten').browse_media()<CR>
nnoremap <leader>ga :lua require('telekasten').show_tags()<CR>
nnoremap <leader>gr :lua require('telekasten').rename_note()<CR>
nnoremap <leader>gl <cmd>:lua require('telekasten').insert_link({ i=true })<CR>
nnoremap <leader>gv :lua require('telekasten').switch_vault()<CR>

" on hesitation, bring up the panel
nnoremap <leader>g :lua require('telekasten').panel()<CR>

" we could define [[ in **insert mode** to call insert link
"inoremap [[ <cmd>:lua require('telekasten').insert_link()<CR>
" alternatively: leader [
"inoremap <leader>z[ <cmd>:lua require('telekasten').insert_link({ i=true })<CR>
"inoremap <leader>zt <cmd>:lua require('telekasten').toggle_todo({ i=true })<CR>
"inoremap <leader># <cmd>lua require('telekasten').show_tags({i = true})<cr>

set mouse=
