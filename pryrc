# vim: ft=ruby
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 's', 'step'
end

Pry.commands.alias_command 'e', 'edit'
Pry.commands.alias_command 'sd', 'show-doc'
Pry.commands.alias_command 'sm', 'show-method'
Pry.commands.alias_command 'bt', 'pry-backtrace'
Pry.commands.alias_command 'w', 'whereami'
Pry.commands.alias_command 'ww', 'whereami 30'

Pry::Commands.command(/^$/, 'repeat last command') do
  _pry_.run_command Pry.history.to_a.last
end
