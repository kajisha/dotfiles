nnoremap [vim-rails] <Nop>
nmap <Leader>r [vim-rails]

nnoremap <silent> [vim-rails]a :AV<CR>
nnoremap <silent> [vim-rails]r :RV<CR>

let g:rails_projections = {
    \  "app/controllers/*_controller.rb": {
    \      "test": [
    \        "spec/requests/{}_spec.rb",
    \        "spec/controllers/{}_controller_spec.rb",
    \        "test/controllers/{}_controller_test.rb"
    \      ],
    \      "alternate": [
    \        "spec/requests/{}_spec.rb",
    \        "spec/controllers/{}_controller_spec.rb",
    \        "test/controllers/{}_controller_test.rb"
    \      ],
    \   },
    \   "spec/requests/*_spec.rb": {
    \      "command": "request",
    \      "alternate": "app/controllers/{}_controller.rb",
    \      "template": "require 'rails_helper'\n\n" .
    \        "RSpec.describe '{}' do\nend",
    \   },
    \ }
