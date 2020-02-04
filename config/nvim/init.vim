set termguicolors

" Leader
let mapleader = ","
noremap \ ,

set autowrite     " Automatically :write before running commands
set backspace=2   " Backspace deletes like most programs in insert mode
set fileencodings=ucs-bom,utf-8,iso-2022-jp,cp932,euc-jp,default,latin
set history=50
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set nobackup
set nolist
set nonumber
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set nowrap
set nowritebackup
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set textwidth=0

syntax on
filetype plugin indent on

runtime! plugins.vim

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  " autocmd BufReadPost *
  "   \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  "   \   exe "normal g`\"" |
  "   \ endif
augroup END

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

colorscheme kalisi
set background=dark

imap <C-[> <Esc>
noremap ; :
nnoremap <C-c><C-c> :<C-u>nohlsearch<cr><Esc>

" Switch between the last two files
nnoremap <leader><leader> <c-^>
