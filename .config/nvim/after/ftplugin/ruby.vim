setl iskeyword+=",?,!,$,="

if filereadable('.standard.yml')
  let g:ale_fixers = { 'ruby': ['standardrb'] }
elseif filereadable('.rubocop.yml')
  let g:ale_fixers = { 'ruby': ['rubocop'] }
endif

let g:ale_ruby_standardrb_executable = 'bundle'

if filereadable('docker-compose.yml')
  let test#ruby#rspec#executable = 'docker compose run --rm $APP_NAME bundle exec rspec'
else
  let test#ruby#rspec#executable = 'bin/rspec'
endif
