let test#strategy = 'neovim'
let test#ruby#rspec#executable = filereadable('docker-compose.yml') ? 'docker-compose run --rm $APP_NAME bundle exec rspec' : 'bundle exec rspec'
let g:test#preserve_screen = 1
