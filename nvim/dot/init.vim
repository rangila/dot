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
Plug 'sainnhe/everforest'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'tpope/vim-obsession'
Plug 'rbong/vim-flog'
Plug 'rhysd/git-messenger.vim'
Plug 'lervag/wiki.vim'
Plug 'michal-h21/vim-zettel'
if has("nvim-0.5.0")
	" Statistics about your keystrokes
	Plug 'ThePrimeagen/vim-apm'
	" language parser for better syntax highlighting, refactoring, navigation,
	" text objects, folding and more
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-treesitter/nvim-treesitter-refactor'
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'nvim-treesitter/playground'
	" Configuration for most commonly used language servers
	" :LspInfo shows the status of active and configured language servers
	Plug 'neovim/nvim-lspconfig'
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	Plug 'danymat/neogen'
end
if has("nvim-0.6.0")
	" telekasten
	Plug 'renerocksai/telekasten.nvim'
	Plug 'renerocksai/calendar-vim'
end
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

"" nvim-gdb
"" =============================================================================

let g:nvimgdb_use_find_executables = 0
let g:nvimgdb_use_cmake_to_find_executables = 0

"" clang-format on save
"" =============================================================================
function FormatBufferConditional()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format-16
    call setpos('.', cursor_pos)
  endif
endfunction

function FormatBuffer()
    let cursor_pos = getpos('.')
    :%!clang-format-16
    call setpos('.', cursor_pos)
endfunction

"autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()
nnoremap <silent> <leader>aa :call FormatBuffer()<CR>

"" Treesitter
"" =============================================================================

if has("nvim-0.5.0")
	"nvim-treesitter configuration
lua <<EOF

require'nvim-treesitter.configs'.setup {
  ensure_installed = "c", "cpp",     -- one of "all", "language", or a list of languages
  highlight = {
	enable = true,              -- false will disable the whole extension
	disable = {},  -- list of language that will be disabled
  },
  refactor = {
    highlight_definitions = { enable = false },
	highlight_current_scope = { enable = false },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "<a-*>",
        goto_previous_usage = "<a-#>",
      },
    },
  },
  textobjects = {
    -- possible text objects:
    -- @block.inner
    -- @block.outer
    -- @call.inner
    -- @call.outer
    -- @class.inner
    -- @class.outer
    -- @comment.outer
    -- @conditional.inner
    -- @conditional.outer
    -- @function.inner
    -- @function.outer
    -- @loop.inner
    -- @loop.outer
    -- @parameter.inner
    -- @statement.outer
	select = {
	  enable = true,
	  keymaps = {
		["af"] = "@function.outer",
		["if"] = "@function.inner",
		["ac"] = "@class.outer",
		["ic"] = "@class.inner",
		},
	  },
	move = {
	  enable = true,
	  goto_next_start = {
		["]m"] = "@function.outer",
		["]]"] = "@class.outer",
	  },
	  goto_next_end = {
		["]M"] = "@function.outer",
		["]["] = "@class.outer",
	  },
	  goto_previous_start = {
		["[m"] = "@function.outer",
		["[["] = "@class.outer",
	  },
	  goto_previous_end = {
		["[M"] = "@function.outer",
		["[]"] = "@class.outer",
	  },
	},
	swap = {
	  enable = true,
	  swap_next = {
		["<leader>s"] = "@parameter.inner",
	  },
	  swap_previous = {
		["<leader>S"] = "@parameter.inner",
	  },
	},
  },
  indent = {
    enable = false,
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
}
require('neogen').setup {
	enabled = true,
}

--require "nvim-treesitter".setup()
--require "nvim-treesitter.highlight"
--local hlmap = vim.treesitter.highlighter.hl_map
--
----Misc
--hlmap.error = nil

-- local hlmap = vim.treesitter.highlighter.hl_map
-- hlmap.error = nil

EOF
end

"" telekasten
"" =============================================================================
if has("nvim-0.6.0")
lua << END
local home = vim.fn.expand("~/zettelkasten")
local home2 = vim.fn.expand("~/doc/obsidian/General/")
require('telekasten').setup({
    home         = home,

    -- if true, telekasten will be enabled when opening a note within the configured home
    take_over_my_home = true,

    -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
    --                               and thus the telekasten syntax will not be loaded either
    auto_set_filetype = true,

    -- dir names for special notes (absolute path or subdir name)
    dailies      = home .. '/' .. 'daily',
    weeklies     = home .. '/' .. 'weekly',
    templates    = home .. '/' .. 'templates',

    -- image (sub)dir for pasting
    -- dir name (absolute path or subdir name)
    -- or nil if pasted images shouldn't go into a special subdir
    image_subdir = "img",

    -- markdown file extension
    extension    = ".md",

    -- Generate note filenames. One of:
    -- "title" (default) - Use title if supplied, uuid otherwise
    -- "uuid" - Use uuid
    -- "uuid-title" - Prefix title by uuid
    -- "title-uuid" - Suffix title with uuid
    new_note_filename = "title",
    -- file uuid type ("rand" or input for os.date()")
    uuid_type = "%Y%m%d%H%M",
    -- UUID separator
    uuid_sep = "-",

    -- following a link to a non-existing note will create it
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,

    -- skip telescope prompt for goto_today and goto_thisweek
    journal_auto_open = false,

    -- template for new notes (new_note, follow_link)
    -- set to `nil` or do not specify if you do not want a template
    template_new_note = home .. '/' .. 'templates/new_note.md',

    -- template for newly created daily notes (goto_today)
    -- set to `nil` or do not specify if you do not want a template
    template_new_daily = home .. '/' .. 'templates/daily.md',

    -- template for newly created weekly notes (goto_thisweek)
    -- set to `nil` or do not specify if you do not want a template
    template_new_weekly= home .. '/' .. 'templates/weekly.md',

    -- image link style
    -- wiki:     ![[image name]]
    -- markdown: ![](image_subdir/xxxxx.png)
    image_link_style = "markdown",

    -- default sort option: 'filename', 'modified'
    sort = "filename",

    -- integrate with calendar-vim
    plug_into_calendar = true,
    calendar_opts = {
        -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
        weeknm = 4,
        -- use monday as first day of week: 1 .. true, 0 .. false
        calendar_monday = 1,
        -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
        calendar_mark = 'left-fit',
    },

    -- telescope actions behavior
    close_after_yanking = false,
    insert_after_inserting = true,

    -- tag notation: '#tag', ':tag:', 'yaml-bare'
    tag_notation = "#tag",

    -- command palette theme: dropdown (window) or ivy (bottom panel)
    command_palette_theme = "dropdown",

    -- tag list theme:
    -- get_cursor: small tag list at cursor; ivy and dropdown like above
    show_tags_theme = "dropdown",

    -- when linking to a note in subdir/, create a [[subdir/title]] link
    -- instead of a [[title only]] link
    subdirs_in_links = true,

    -- template_handling
    -- What to do when creating a new note via `new_note()` or `follow_link()`
    -- to a non-existing note
    -- - prefer_new_note: use `new_note` template
    -- - smart: if day or week is detected in title, use daily / weekly templates (default)
    -- - always_ask: always ask before creating a note
    template_handling = "smart",

    -- path handling:
    --   this applies to:
    --     - new_note()
    --     - new_templated_note()
    --     - follow_link() to non-existing note
    --
    --   it does NOT apply to:
    --     - goto_today()
    --     - goto_thisweek()
    --
    --   Valid options:
    --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
    --              all other ones in home, except for notes/with/subdirs/in/title.
    --              (default)
    --
    --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
    --                    except for notes with subdirs/in/title.
    --
    --     - same_as_current: put all new notes in the dir of the current note if
    --                        present or else in home
    --                        except for notes/with/subdirs/in/title.
    new_note_location = "smart",

    -- should all links be updated when a file is renamed
    rename_update_links = true,

    vaults = {
        vault2 = {
            -- alternate configuration for vault2 here. Missing values are defaulted to
            -- default values from telekasten.
            -- e.g.
            home = home2,
        },
    },

    -- how to preview media files
    -- "telescope-media-files" if you have telescope-media-files.nvim installed
    -- "catimg-previewer" if you have catimg installed
    media_previewer = "telescope-media-files",

    -- A customizable fallback handler for urls.
    follow_url_fallback = nil,
})
END
end

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
