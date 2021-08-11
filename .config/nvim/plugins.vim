call plug#begin('~/.local/share/nvim/plugged')
Plug 'flazz/vim-colorschemes'

Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

Plug 'Pocco81/AbbrevMan.nvim', { 'branch': 'main' }

Plug 'rhysd/committia.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'idanarye/vim-merginal'

Plug 'pbrisbin/vim-mkdir'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'

Plug 'cohama/lexima.vim'
Plug 'tpope/vim-abolish'
Plug 'Yggdroot/indentLine'

Plug 'kassio/neoterm'

Plug 'godlygeek/tabular' | Plug 'sheerun/vim-polyglot'
Plug 'gentoo/gentoo-syntax'
Plug 'tomtom/tcomment_vim'
Plug 'editorconfig/editorconfig-vim'

Plug 'dense-analysis/ale'

Plug 'tpope/vim-rails', { 'for': ['ruby'] }
Plug 'tpope/vim-bundler', { 'for': ['ruby'] }
Plug 'vim-test/vim-test'

Plug 'mattn/vim-sqlfmt'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

runtime! plugins/*.vim
