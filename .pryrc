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
Pry.editor = "nvim"

# require "awesome_print"

dev_prompt = proc { |context, nesting, pry_instance, sep|
  format(
    "[%<in_count>s] #{MAGENTA}%<name>s(#{RESET}%<context>s#{MAGENTA})#{RESET}%<nesting>s%<separator>s ",
    in_count: pry_instance.input_ring.count,
    name: pry_instance.config.prompt_name,
    context: Pry.view_clip(context),
    nesting: (nesting > 0 ? ":#{nesting}" : ''),
    separator: sep
  )
}

old_dev_prompt = proc { |target_self, nest_level, pry|
  line_num = pry.input_ring.size
  prompt = "#{line_num} "
  "#{MAGENTA}#{prompt}#{RESET}"
}

# custom prompt
Pry.config.prompt = Pry::Prompt.new(
  :dev,
  "dev prompt",
  [
    dev_prompt,
    proc { |*args| "#{MAGENTA}. #{RESET}" },
  ],
)

if self.class.const_defined?("Rails") && Rails.env.test?
  default_prompt = Pry::Prompt[:default]
  env = Pry::Helpers::Text.red(Rails.env.upcase)
  Pry.config.prompt = Pry::Prompt.new(
    :test,
    "test prompt",
    [
      proc { |*args| "#{env} #{default_prompt.wait_proc.call(*args)}" },
      proc { |*args| "#{env} #{default_prompt.incomplete_proc.call(*args)}" },
    ],
  )
end

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
