require 'capybara'

# Firefox
Capybara.register_driver :firefox do | app |
  Capybara::Selenium::Driver.new(app)
end

# Chrome todo activate chrome driver
Capybara.register_driver :chrome do | app |
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_wait_time = 10
Capybara.default_selector = :css

Capybara.default_driver = (ENV['DRIVER'] || :chrome).to_sym
Capybara.app_host = get_env_url