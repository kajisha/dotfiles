set termguicolors

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
set hidden

syntax on
filetype plugin indent on

runtime! plugins.vim

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

colorscheme gruvbox
set background=dark

" Show keybingins
command Keybind vsp ~/.config/nvim/plugins/keybindings.vim
