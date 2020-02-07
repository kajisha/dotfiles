let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
let g:ale_enabled = 1
let g:ale_fix_on_save = 1

let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'css': ['prettier'],
\   'ruby': ['rubocop'],
\}

let g:ale_ruby_rubocop_executable = 'bundle'
