" let g:ale_fixers = { 'javascript': ['eslint'] }
let g:test#javascript#jasmine#file_pattern = '\v^__tests__[\\/].*spec\.(js|jsx)$'
let test#javascript#jest#executable = 'npx jest'
