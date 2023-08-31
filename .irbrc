# vim:filetype=ruby

BLACK = "\001\e[0;30m\002".freeze
RED = "\001\e[0;31m\002".freeze
GREEN = "\001\e[0;32m\002".freeze
YELLOW = "\001\e[0;33m\002".freeze
BLUE = "\001\e[0;34m\002".freeze
MAGENTA = "\001\e[0;35m\002".freeze
CYAN = "\001\e[0;36m\002".freeze
WHITE = "\001\e[0;37m\002".freeze
RESET = "\001\e[0m\002".freeze

BOLD = "\001\e[1m\002".freeze
UNDERLINE = "\001\e[4m\002".freeze
BLINK = "\001\e[5m\002".freeze
REVERSE = "\001\e[7m\002".freeze
CONCEALED = "\001\e[8m\002".freeze
PLAIN = "\001\e[0m\002".freeze
ITALIC = "\001\e[3m\002".freeze

def rails_prompt
  def_prompt = "[#{MAGENTA}%01n#{RESET}]"

  if defined?(Rails)
    app_env = Rails.env[0..4]

    if Rails.env.production?
      app_env = "#{RED}#{app_env}#{RESET}"
    else
      app_env = "#{GREEN}#{app_env}#{RESET}"
    end

    def_prompt << " (#{BOLD}#{app_env}#{PLAIN})"
  end

  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:CUSTOM] = {
    :PROMPT_I => "#{def_prompt} > ",
    :PROMPT_N => "#{def_prompt} .. ",
    :PROMPT_C => "#{def_prompt} .. ",
    :PROMPT_S => "#{def_prompt} %l ",
    :RETURN => "=> %s\n",
    AUTO_INDENT: true,
    USE_READLINE: false,
  }
  IRB.conf[:PROMPT_MODE] = :CUSTOM
end

if ENV.fetch("RAILS_ENV", nil)
  rails_prompt

  # IRB.conf[:IRB_RC] = Proc.new do
  #   logger = Logger.new(STDOUT)
  #   ActiveRecord::Base.logger = logger
  # end
end
