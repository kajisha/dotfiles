set termguicolors

" Leader
let mapleader = ","
noremap \ ,

call config#initializers#dein#load()

set autowrite     " Automatically :write before running commands
set backspace=2   " Backspace deletes like most programs in insert mode
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,cp932,euc-jp,default,latin
set fileencoding=utf-8
set fileformat=unix
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
set tags+=./tags,Gemfile.lock.tags,composer.lock.tags
set textwidth=0

syntax on
filetype plugin indent on

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd BufWritePre * :%s/\s\+$//ge
augroup END

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

call config#initializers#grep#setup()

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Always use vertical diffs
set diffopt+=vertical

colorscheme kalisi
set background=dark

" syntastic
" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-", " proprietray attribute \"v-", " proprietary attribute \"debounce"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}
let g:syntastic_ocaml_checkers = ['merlin']
let g:syntastic_javascript_checkers = ['eslint'] " syntastic-local-eslint.vim

" fzf
set rtp+=~/.fzf

" deoplete
let g:deoplete#enable_at_startup = 1

" unite.vim
let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '-w --nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" vim-tags
let g:vim_tags_project_tags_command = "/usr/bin/ctags -f tags -R . 2>/dev/null"

" indentLine
set list lcs=tab:\|\
let g:indentLine_enabled = 1

" vim-gitgutter
let g:gitgutter_sign_column_always = 1
let g:gitgutter_max_signs = 500
highlight clear SignColumn

" merlin(ocaml)
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
execute "set rtp^=" . g:opamshare . "/ocp-indent/vim"

source $HOME/.config/nvim/keymaps.vim
