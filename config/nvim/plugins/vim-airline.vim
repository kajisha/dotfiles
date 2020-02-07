let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 0
let g:airline_theme = 'luna'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''

let s:lsep = " %{get(g:, 'airline_left_alt_sep', '')}"
let s:rsep = " %{get(g:, 'airline_right_alt_sep', '')}"
let g:airline_section_b =
      \ "%{airline#extensions#branch#get_head()}"
let g:airline_section = ''
let g:airline_section_x =
      \ "%{strlen(&fileformat)?&fileformat:''}".s:rsep.
      \ "%{strlen(&fenc)?&fenc:&enc}".s:rsep.
      \ "%{strlen(&filetype)?&filetype:'no ft'}"
let g:airline_section_y = '%3p%%'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%31:%-2v'
