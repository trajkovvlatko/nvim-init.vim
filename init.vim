call plug#begin('~/.config/nvim/plugged')
Plug 'jlanzarotta/bufexplorer' " list of active buffers
Plug 'scrooloose/nerdtree' " sidebar
Plug 'prettier/vim-prettier', { 'do': 'yarn install' } " code formater
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'preservim/nerdcommenter' " easier comments per file type
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'jparise/vim-graphql'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-rails'
Plug 'vim-test/vim-test'
Plug 'tpope/vim-endwise'
Plug 'windwp/nvim-autopairs'
Plug 'dense-analysis/ale'
Plug 'github/copilot.vim'
Plug 'folke/tokyonight.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kdheepak/lazygit.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
call plug#end()

" require("noice").setup()
lua << EOF
require("nvim-autopairs").setup({})
require('lualine').setup {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {''},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  icons_enabled = false,
}

vim.api.nvim_set_keymap('n', '<C-f>', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
require('telescope').setup({
  defaults = {
    layout_config = {
      prompt_position = 'top',
    },
    preview = false,
    sorting_strategy = "ascending",
  },
})
EOF

colorscheme tokyonight-night

set mouse=n

set clipboard+=unnamedplus

" ALE
let b:ale_fixers = ['rubocop']
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_fix_on_save = 0
let g:ale_pattern_options = {
\   '.*\.js$': {'ale_enabled': 0},
\   '.*\.jsx$': {'ale_enabled': 0},
\   '.*\.tsx$': {'ale_enabled': 0},
\}

nmap <C-k> <cr>:ALEFix rubocop<cr>

" Turn on syntax highlighting
syntax on

" Change the mapleader from \ to ,
let mapleader = ","

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Set command line history limit
set history=1000

" Display line numbers
set number

" Display ... as wrap break
set showbreak=...

" Proper wrapping
set wrap linebreak nolist

" Add some line space for easy reading
set linespace=4

" Store temporary files in a central spot
set backupdir=~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.nvim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Indentation settings
set shiftwidth=2
set softtabstop=2
set expandtab
" set autoindent

" Folding settings
set foldmethod=indent

" Set deepest folding to 3 levels
set foldnestmax=3

" Don't fold by default
set nofoldenable

" Activate TAB auto-complete for file paths
" set wildmode=longest,list

" Make tab completion for files/buffers act like bash
" set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" Allow backgrounding buffers without saving them
set hidden

" set cursorcolumn
hi ColorColumn ctermbg=DarkGray

" Use Ack instead of grep
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
set grepprg=ack

" Map ESC
imap jj <ESC>
imap <c-c> <ESC>

" Switch between last two buffers
nnoremap <leader><leader> <c-^>

" Disable arrow keys
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

" Make & trigger :&& so it preserves flags
nnoremap & :&&<Enter>
xnoremap & :&&<Enter>

" Paste last yanked text
map <c-p> "0p

" Edit/View files relative to current directory
cnoremap %% <c-R>=expand('%:h').'/'<cr>
map <leader>re :edit %%
map <leader>rv :view %%

" Ctags
nnoremap <f5> :!ctags -R --exclude=.git --exclude=log *<cr>

" Switch between buffers
noremap <tab> :bn<cr>
noremap <S-tab> :bp<cr>

" Close buffer
nmap <leader>bd :bprevious<cr>:bdelete #<cr>

" Close all buffers
nmap <leader>bD :bufdo bd<cr>

" Clear the search buffer when hitting return
:nnoremap <cr> :nohlsearch<cr>

set statusline=%f       "tail of the filename
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

" vim-gutter
set signcolumn=yes

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

let g:jsx_ext_required = 0

" Max 80 chars per line
set colorcolumn=129

set splitbelow

set redrawtime=10000

filetype plugin on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-eslint',
  \ ]

set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

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
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

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
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Prettify
nmap <Leader>py <Plug>(Prettier)
" let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
map \\ <plug>NERDCommenterToggle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
let NERDTreeWinSize = 32
let NERDTreeIgnore=['\.ljbc$', '\.o$', '\~$']
map <leader>p :silent! NERDTreeToggle<cr>
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeGitStatusNodeColorization = 1

set wildignore+=*.ljbc,*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*
let NERDTreeRespectWildIgnore=1
let g:NERDTreeIgnore = ['^node_modules$']
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" StatusLine
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '[\s]'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunction

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning =  '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    else
      let b:statusline_tab_warning = ''
    endif
  endif
  return b:statusline_tab_warning
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Jump to last cursor position when opening a file except when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  end
endfunction

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
" autocmd BufWritePre *.rb :call <SID>StripTrailingWhitespaces()
autocmd FileType c,cpp,scss,css,html,erb,java,php,ruby,python,javascript autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
nnoremap <leader>cs :call <SID>StripTrailingWhitespaces()<cr>

" Move lines up or down, Alt + j/k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" vim-test
let test#strategy = "neovim"

" Run nearest test
nmap <C-t> <cr>:TestNearest<cr>
nmap <C-y> <cr>:TestFile<cr>
