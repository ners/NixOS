" /////////
" Global
" /////////

syntax on
set t_Co=256
set t_ut=
set number
set autoindent smartindent
set incsearch hlsearch
set ignorecase smartcase
set splitright splitbelow
set updatetime=1000
set signcolumn=yes
set rtp+=/opt/homebrew/opt/fzf
set rtp+=/Users/rekk/.nix-profile/bin
set scrolloff=0
set cursorline
set inccommand=nosplit
set completeopt=menu,menuone,noselect

" use fourmolu
let g:ormolu_command="fourmolu"

" Filetype detection
filetype on
filetype plugin on
filetype indent on

" Autoread on focus (kind of broken)
set autoread
au FocusGained * :checktime

" ctrl + s to save file
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

" Persistent undo
set undofile
set undolevels=1000
set undoreload=10000

" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" set list listchars=tab:›\ ,trail:~,extends:»,precedes:«,nbsp:_
set tabstop=2

" Theme
colorscheme edge
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_y = ''
let g:airline_section_z = ''

" Bufferline settings (barbar)
" let bufferline = get(g:, 'bufferline', {})
" let bufferline.icons = 'buffer_number'
" let bufferline.animation = v:true
" let bufferline.clickable = v:true

" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif

" navigate splits with ctrl + j/l/h/k
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" add/close tabs with ctrl + t / w
" nnoremap <C-t> :tabnew<CR>
" nnoremap <C-w> :tabclose<CR>

" navigate tabs with shift + h / l
nnoremap H :BufferPrevious<CR>
nnoremap L :BufferNext<CR>

" Switch to specific tab numbers with g + number
noremap g1 :BufferGoto 1<CR>
noremap g2 :BufferGoto 2<CR>
noremap g3 :BufferGoto 3<CR>
noremap g4 :BufferGoto 4<CR>
noremap g5 :BufferGoto 5<CR>
noremap g6 :BufferGoto 6<CR>
noremap g7 :BufferGoto 7<CR>
noremap g8 :BufferGoto 8<CR>
noremap g9 :BufferGoto 9<CR>
noremap g0 :BufferLast<CR>
" noremap g` :tabfirst<CR>
nnoremap ZZ :bd<CR>

" Disable recording with q
" map q <Nop>

" Disable entering ex-mode with Q
:map Q <Nop>

" ctrl + c/x/v for text actions
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" ctrl + l to split last buffer
nnoremap <A-n> :vert sb#<Enter>

" This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR>

" set filetypes
au BufRead,BufNewFile *.js set syntax=javascript
au BufRead,BufNewFile *.ts set syntax=typescript filetype=typescriptreact
au BufRead,BufNewFile *.tsx set syntax=typescriptreact filetype=typescriptreact
au BufRead,BufNewFile *.nix set syntax=nix
au BufRead,BufNewFile *.elm set filetype=elm
au BufRead,BufNewFile *.edn set filetype=clojure
set expandtab
set tabstop=4
set shiftwidth=4
" autocmd Filetype typescript set noexpandtab tabstop=2 sts=2 sw=2
" autocmd Filetype typescriptreact set noexpandtab tabstop=2 sts=2 sw=2
" autocmd Filetype javascript set noexpandtab tabstop=2 sts=2 sw=2
" autocmd Filetype nix set noexpandtab tabstop=2 sts=2 sw=2

let g:sql_type_default = 'pgsql'
let g:omni_sql_default_compl_type = 'syntax'

" folding
" set foldmethod=indent   
" set foldnestmax=10
" set nofoldenable
" set foldlevel=2

" Run this to start profiling
" :profile start profile.log | profile func * | profile file *

" /////////
" Plugin-specific settings
" /////////

" /////////
" Conjure
" /////////

" backslash as local leader
let maplocalleader="\\"
let g:conjure#mapping#eval_current_form = "<localleader><localleader>"
let g:conjure#mapping#eval_root_form = "<localleader>r"

" /////////
" Nvim-Tree
" /////////

" ctrl + n to open 
map <C-n> :NvimTreeToggle<CR>

" Use ctrl + , to find current file in tree
map <C-,> :NvimTreeFindFile<CR>

" Use h and l to navigate NERDTree subdirs
autocmd FileType nvimtree nmap <buffer> h o
autocmd FileType nvimtree nmap <buffer> l o

" NERDTree settings (deprecated)
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:DevIconsEnableFoldersOpenClose = 1
" let g:DevIconsEnableFolderExtensionPatternMatching = 1
" let g:DevIconsDefaultFolderOpenSymbol='ﱮ'
" let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol=''
" let g:NERDTreeDirArrowExpandable = ""
" let g:NERDTreeDirArrowCollapsible = ""
" let g:NERDTreeAutoDeleteBuffer = 1
" let g:NERDTreeMinimalUI = 1
" let g:NERDTreeDirArrows = 0
" let g:NERDTreeGitStatusUseNerdFonts = 1
" let g:NERDTreeShowHidden=1

" /////////
" NERDTree (deprecated)
" /////////

" ctrl + n to open NERDTree
" map <C-n> :NERDTreeToggle<CR>

" Use ctrl + , to find current file in tree
" map <C-,> :NERDTreeFind<CR>

" ctrl + s to save file
" :nmap <c-s> :w<CR>
" :imap <c-s> <Esc>:w<CR>a

" Use h and l to navigate NERDTree subdirs
" autocmd FileType nerdtree nmap <buffer> h o
" autocmd FileType nerdtree nmap <buffer> l o

" /////////
" AG (deprecated)
" /////////

" use Ag with ack.vim
" let g:ackprg = 'ag --nogroup --nocolor --column'

" shift + f to search
" nnoremap F :Ack<enter>

" /////////
" fugitive
" /////////

" ctrl + g for git menu
nnoremap <c-g> :G<enter>
" /////////
" fzf-lua
" /////////

" F for fuzzy search
nnoremap F :FzfLua grep<enter><enter>
vnoremap F <cmd>FzfLua grep_visual<enter><enter>
" f for fuzzy file search
nnoremap f :FzfLua git_files<enter>
" g + l for git log
nnoremap gl :FzfLua git_commits<enter>
" g + c for git conflict resolution
nnoremap gc :Gdiffsplit!<enter>
" g + b for git branches
nnoremap gb :FzfLua git_branches<enter>

let g:fzf_checkout_git_options = '--sort=-committerdate'

" fzf selected file actions 
let g:fzf_action = {
  \ 'ctrl-d': 'vert diffs',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" fzf window height and colours
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.5 } }
let g:fzf_colors = { 'fg': ['fg', 'CursorLine'], 'bg': ['bg', 'CursorLine'] }
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" /////////
" FZF (old)
" /////////

" F for fuzzy search
" nnoremap F :Rg<enter>
" alt + o for fuzzy file search
" nnoremap ø :GFiles<enter>
" ctrl + g for git menu
" nnoremap <c-g> :G<enter>
" g + l for git log
" nnoremap gl :Commits<enter>
" g + c for git conflict resolution
" nnoremap gc :Gdiffsplit!<enter>
" g + b for git branches
" nnoremap gb :GBranches<enter>

" /////////
" Closetag
" /////////
" let g:closetag_filenames = '*.html,*.jsx,*.tsx'
" let g:closetag_xhtml_filenames = '*.html,*.jsx,*.tsx'
" let g:closetag_filetypes = '*.html,*.jsx,*.tsx'
" let g:closetag_xhtml_filetypes = '*.html,*.jsx,*.tsx'

" /////////
" GitGutter
" /////////

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
highlight BufferCurrent   guifg=white

" /////////
" Code Action Menu
" /////////

map , :CodeActionMenu<CR>

" /////////
" CoC
" /////////

" GoTo code navigation.
" autocmd FileType typescriptreact map <silent> gt <Plug>(coc-type-definition)
" autocmd FileType typescriptreact map <silent> gd <Plug>(coc-definition)
" autocmd FileType typescriptreact map <silent> gi <Plug>(coc-implementation)
" autocmd FileType typescriptreact map <silent> gr <Plug>(coc-references)
" autocmd FileType typescriptreact map <silent> rr <Plug>(coc-refactor)
" autocmd FileType typescriptreact noremap <silent> ` :call CocActionAsync('doHover')<CR>

" Use , to run CocAction
" autocmd FileType typescriptreact map , <Plug>(coc-codeaction)

" setup CoC for tsserver
" let g:coc_node_path = '/Users/rekk/.nix-profile/bin/node'

" use <tab> for trigger completion and navigate to the next complete item
" function! s:check_back_space() abort
" let col = col('.') - 1
" return !col || getline('.')[col - 1]  =~ '\s'
" endfunction
" 
" inoremap <silent><expr> <Tab>
" \ pumvisible() ? "\<C-n>" :
" \ <SID>check_back_space() ? "\<Tab>" :
" \ coc#refresh()

" formatting with prettier
" command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
" autocmd FileType * let b:coc_suggest_disable = 1

" /////////
" conflict-marker-vim
" /////////

" Mark conflicts
" disable the default highlight group
let g:conflict_marker_highlight_group = ''

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
highlight ConflictMarkerCommonAncestorsHunk guibg=#754a81


" /////////
" vim-startify
" /////////

" very important startify dragon
" let g:ascii = [
" \'           \                    ^    /^',
" \'            \                  / \  // \',
" \'             \   |\___/|      /   \//  .\',
" \'              \  /O  O  \__  /    //  | \ \           *----*',
" \'                /     /  \/_/    //   |  \  \          \   |',
" \'                @___@`    \/_   //    |   \   \         \/\ \',
" \'               0/0/|       \/_ //     |    \    \         \  \',
" \'           0/0/0/0/|        \///      |     \     \       |  |',
" \'        0/0/0/0/0/_|_ /   (  //       |      \     _\     |  /',
" \'     0/0/0/0/0/0/`/,_ _ _/  ) ; -.    |    _ _\.-~       /   /',
" \'                 ,-}        _      *-.|.-~-.           .~    ~',
" \'                  `/\      /                 ~-. _ .-~      /',
" \'                     *.   }            {                   /',
" \'                    .----~-.\        \-`                 .~',
" \'                    ///.----..<        \             _ -~',
" \'                       ///-._ _ _ _ _ _ _{^ - - - - ~',
" \''
" \]

let g:ascii = [
\' ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
\' ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
\' ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
\' ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
\' ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
\' ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ '
\ ]

let g:startify_custom_header =
      \ 'startify#pad(g:ascii)'

" /////////
" copilot-vim
" /////////

let g:copilot_no_tab_map = v:true
let g:copilot_assume_mapped = v:true
let g:copilot_tab_fallback = ""
