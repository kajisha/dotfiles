call plug#begin('~/.local/share/nvim/plugged')
Plug 'flazz/vim-colorschemes'

Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

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
Plug 'tomtom/tcomment_vim'
Plug 'editorconfig/editorconfig-vim'

Plug 'dense-analysis/ale'

Plug 'tpope/vim-rails'
Plug 'janko-m/vim-test'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-emoji.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'yami-beta/asyncomplete-omni.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
call plug#end()

runtime! plugins/*.vim
