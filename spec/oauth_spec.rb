require 'spec_helper'

describe 'OAuth 1.0 algorithm' do
  context 'GET' do
    context 'valid auth' do
      before :all do
        sign = Api::HTTPRequest.new(consumer_key_cfg, consumer_secret_cfg)
        @request = sign.get(url_cfg + '/signature-test')
      end
      it 'should accept signature' do
        send @request[:method], @request[:url], @request[:headers]
        expect_status 200
        expect_json({status: "signature accepted."})
      end
    end
  end
end