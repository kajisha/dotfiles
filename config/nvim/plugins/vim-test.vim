let test#strategy = 'neovim'
if filereadable('docker-compose.yml')
  let test#ruby#rspec#executable = 'docker-compose run --rm $APP_NAME bin/rspec'
endif
let g:test#preserve_screen = 1
