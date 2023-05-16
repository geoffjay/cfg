# vim:filetype=ruby

# colours
BLACK = "\001\e[0;30m\002"
RED = "\001\e[0;31m\002"
GREEN = "\001\e[0;32m\002"
YELLOW = "\001\e[0;33m\002"
BLUE = "\001\e[0;34m\002"
MAGENTA = "\001\e[0;35m\002"
CYAN = "\001\e[0;36m\002"
WHITE = "\001\e[0;37m\002"
RESET = "\001\e[0m\002"

# editor setup
Pry.editor = "vi"

# require "awesome_print"

# custom prompt
Pry.prompt = [
  proc { |target_self, nest_level, pry|
    line_num = pry.input_array.size
    prompt = "#{line_num} "
    "#{MAGENTA}#{prompt}#{RESET}"
  },
  proc { |target_self, nest_level, pry|
    prompt = ". "
    "#{MAGENTA}#{prompt}#{RESET}"
  }
]

Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# when used through vim
if ENV["VIM"]
  puts "Pry is running inside Vim. Disabling pager."
  Pry.config.pager = false
end
