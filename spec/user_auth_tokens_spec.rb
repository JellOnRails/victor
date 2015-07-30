require 'spec_helper'

describe 'user authentication tokens' do
  context 'POST' do
    context 'with valid user credentials' do
      before do
        user = get_user_info('api_user', API_CFG)
        sign = Api::HTTPRequest.new(consumer_key_cfg, consumer_secret_cfg)
        @request = sign.post(url_cfg + '/user-authentication-tokens', body: {'user-authentication-tokens': [{'username': user['username'], 'password': user['password']}]})
      end
      it 'should return a valid tokens' do
        post @request[:url], @request[:body], @request[:headers]
        expect_status 201
        expect_json_keys(:'user-authentication-tokens',
                         [
                             [
                                 :id,
                                 :createdAt, [:date, :time, :timeZone]
                             ],
                             :modifiedAt, [:date, :time, :timeZone],
                             :token,
                             :created, [:date, :time, :timeZone],
                             :lastUsed, [:date, :time, :timeZone],
                             :links, [:user],
                         ], :links,
                         [
                             :'user-authentication-tokens.user', [:type]
                         ],
                         :linked)
      end
    end
    context 'with invalid user credentials' do
      before do
        sign = Api::HTTPRequest.new(consumer_key_cfg, consumer_secret_cfg)
        @request = sign.post(url_cfg + '/user-authentication-tokens', body: {'user-authentication-tokens': [{'username': 'wrong_username', 'password': 'wrong password'}]})
      end
      it 'should return a valid tokens' do
        post @request[:url], @request[:body], @request[:headers]
        expect_status 403
        expect_json_keys(:errors, [:type, :title, :detail, :path])
      end
    end
  end
  context 'DELETE' do
    context 'sign out by deleting the token' do
      before :all do
        user = get_user_info('api_user', API_CFG)
        @sign = Api::HTTPRequest.new(consumer_key_cfg, consumer_secret_cfg)
        @opts = {body: {'user-authentication-tokens': [{'username': user['username'], 'password': user['password']}]}}
      end
      before :each do
        request = @sign.post url_cfg + '/user-authentication-tokens', @opts
        post request[:url], request[:body], request[:headers]
        @token = @json_body[:'user-authentication-tokens'].first[:token]
        @request = @sign.delete url_cfg + '/user-authentication-tokens', @opts
      end
      it 'should return valid responce' do
        delete @request[:url], @request[:headers]
        expect_status 200
      end
      it 'user should be signed out' do
        delete @request[:url], @request[:headers]
        request = @sign.get url_cfg + '/passenger', {headers:{userAuthPath: @token}}
        get request[:url], request[:headers]
        expect_status 403
      end
    end
  end
end