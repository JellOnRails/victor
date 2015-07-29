require 'selenium-webdriver'
require 'site_prism'

include SitePrism

SitePrism.configure do | config |
  config.use_implicit_waits = true
end

ENV[ 'ENV' ] ||= 'staging'
puts "Running tests against of #{ENV['ENV']} environment"

CONFIG = YAML.load_file('env.yaml')

