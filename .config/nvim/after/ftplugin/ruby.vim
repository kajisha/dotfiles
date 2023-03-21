setl iskeyword+=",?,!,$,="

if filereadable('docker-compose.yml')
  let test#ruby#rspec#executable = 'docker compose run --rm $APP_NAME bundle exec rspec'
else
  let test#ruby#rspec#executable = 'bin/rspec'
endif
