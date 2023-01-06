let s:jetpackfile = expand('<sfile>:p:h') .. '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack
call jetpack#begin()
Jetpack 'flazz/vim-colorschemes'

Jetpack 'vim-airline/vim-airline' | Jetpack 'vim-airline/vim-airline-themes'

Jetpack 'lambdalisue/fern.vim'
Jetpack 'lambdalisue/nerdfont.vim'
Jetpack 'lambdalisue/fern-renderer-nerdfont.vim'
Jetpack 'lambdalisue/fern-git-status.vim'
Jetpack 'lambdalisue/fern-hijack.vim'
Jetpack 'yuki-yano/fern-preview.vim'
Jetpack 'pbrisbin/vim-mkdir'

Jetpack 'Pocco81/AbbrevMan.nvim', { 'branch': 'main' }

" Git plugins
Jetpack 'rhysd/committia.vim'
Jetpack 'airblade/vim-gitgutter'
Jetpack 'tpope/vim-fugitive'
Jetpack 'tpope/vim-rhubarb'
Jetpack 'idanarye/vim-merginal'

Jetpack 'tpope/vim-repeat'
Jetpack 'tpope/vim-surround'
Jetpack 'junegunn/fzf.vim'
Jetpack 'junegunn/fzf', { 'do': {-> fzf#install()} }
Jetpack 'brooth/far.vim'

Jetpack 'cohama/lexima.vim'
Jetpack 'tpope/vim-abolish'
Jetpack 'lukas-reineke/indent-blankline.nvim'

Jetpack 'godlygeek/tabular' | Jetpack 'sheerun/vim-polyglot'
Jetpack 'tomtom/tcomment_vim'
Jetpack 'editorconfig/editorconfig-vim'

Jetpack 'tpope/vim-rails', { 'for': ['ruby'] }
Jetpack 'vim-test/vim-test'

" LSP, Linter, Formatter, etc.
Jetpack 'neoclide/coc.nvim', {'branch': 'release'}
Jetpack 'dense-analysis/ale'
Jetpack 'mattn/vim-sqlfmt'
call jetpack#end()

runtime! plugins/*.vim
