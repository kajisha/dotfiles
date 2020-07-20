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

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Always use vertical diffs
set diffopt+=vertical

colorscheme gruvbox
set background=dark

" Clipboard
if system('uname -r | grep microsoft') != ""
  let g:clipboard = {
        \   'name': 'wslClipboard',
        \   'copy': {
        \      '+': 'win32yank.exe -i',
        \      '*': 'win32yank.exe -i',
        \    },
        \   'paste': {
        \      '+': 'win32yank.exe -o',
        \      '*': 'win32yank.exe -o',
        \   },
        \   'cache_enabled': 1,
        \ }
endif

" Show keybingins
command Keybind vsp ~/.config/nvim/plugins/keybindings.vim
