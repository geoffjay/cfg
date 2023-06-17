# vim:filetype=ruby

BLACK = "\001\e[0;30m\002"
RED = "\001\e[0;31m\002"
GREEN = "\001\e[0;32m\002"
YELLOW = "\001\e[0;33m\002"
BLUE = "\001\e[0;34m\002"
MAGENTA = "\001\e[0;35m\002"
CYAN = "\001\e[0;36m\002"
WHITE = "\001\e[0;37m\002"
RESET = "\001\e[0m\002"

BOLD = "\001\e[1m\002"
UNDERLINE = "\001\e[4m\002"
BLINK = "\001\e[5m\002"
REVERSE = "\001\e[7m\002"
CONCEALED = "\001\e[8m\002"
PLAIN = "\001\e[0m\002"
ITALIC = "\001\e[3m\002"

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

rails_prompt
