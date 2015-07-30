module ApiHelper

  require 'airborne'
  require 'yaml'

  require_relative 'api'
  require_relative '../features/support/common_actions'

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

  def get_token(usr, auth)
    user = get_user_info(usr, API_CFG)
    request = auth.post(url_cfg + '/user-authentication-tokens', body: {'user-authentication-tokens': [{username: user['username'], password: user['password']}]})
    post request[:url], request[:body], request[:headers]
    @json_body[:'user-authentication-tokens'].first[:token]
  end

  def gen_request_with_token(method = :get, url_path = '/user-authentication-tokens', opts = {}, usr = 'api_user')
    sign = Api::HTTPRequest.new(consumer_key_cfg, consumer_secret_cfg)
    token = get_token(usr, sign)
#    opts.merge!({headers:{userAuthToken: token}})
    sign.send method, url_cfg + url_path, opts.merge({headers:{userAuthToken: token}})
  end

  def delete_token(method = :delete, url_path = '/user-authentication-tokens', opts = {}, usr = 'api_user')
    user = get_user_info(usr, API_CFG)
    sign = Api::HTTPRequest.new(consumer_key_cfg, consumer_secret_cfg)
    request = sign.post(url_cfg + url_path, body: {'user-authentication-tokens': [{'username': user['username'], 'password': user['password']}]})
    post request[:url], request[:body], request[:headers]
    token = @json_body[:'user-authentication-tokens'].first[:token]
    request sign.send method, url_cfg + '/user-authentication-tokens', opts.merge({headers:{userAuthToken: token}})
    delete request[:url], request[:headers]
    token
  end

end