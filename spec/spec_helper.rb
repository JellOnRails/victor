require 'airborne'
require 'yaml'

require_relative '../api/api'


API_CFG = YAML.load_file('api.yaml')

def url_cfg(env = 'staging')
  API_CFG['url'][env]
end

def consumer_key_cfg
  API_CFG['consumer_key']
end

def consumer_secret_cfg
  API_CFG['consumer_secret']
end
