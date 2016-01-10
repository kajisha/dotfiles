" vim:ft=vim

" hylang
let g:python3_host_prog = '$HOME/.pyenv/shims/python'
let g:python3_host_skip_check = 1
let g:hy_enable_conceal = 1

" slimv
let g:slimv_leader = "\\"
let g:slimv_lisp = '/usr/bin/sbcl'
let g:slimv_swank_cmd = '! tmux new-window -d -n REPL-SBCL "sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp '
