module Api

  require 'base64'

  class HTTPRequest

    def initialize(consumer_key, consumer_secret)
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret
    end

    %w{get post patch delete}.each do |m|
      define_method(m) { |path, opts = {}| prepare_request path, m, opts }
    end

    private

    def sign_request(method, path, options)
      #See http://oauth.net/core/1.0a/
      headers = options[:headers].nil? ? {} : options[:headers]
      url = URI.parse(path)
      params = Hash.new
      params.merge! default_params
      if url.query && method.upcase.eql?('GET')
        CGI.parse(url.query).each { |k, v|
          params[url_encode(k)] = v.is_a?(Array) && v.count == 1 ? url_encode(v.first) : url_encode(v)
        }
        params
      end
      if method.upcase.eql?('POST') && headers.has_key?("Content-Type")
        if headers["Content-Type"].eql?("application/x-www-form-urlencoded")
          body = options[:body].nil? ? {} : options[:body]
          CGI.parse(body).each { |k, v|
            params[url_encode(k)] = v.is_a?(Array) && v.count == 1 ? url_encode(v.first) : url_encode(v)
          }
          params
        end
      end
      encoded_params = params.sort.collect { |k, v| url_encode("#{k}=#{v}") }.join('%26')
      base_url = "#{url.scheme}://#{url.host}#{[80,443].include?(url.port) ? "" : ":#{url.port}"}#{url.path}"
      encoded_base_url = url_encode(base_url)
      base_string = method.upcase + '&' + encoded_base_url + '&' + encoded_params
      signing_key = url_encode(@consumer_secret) + '&'
      signing_key += url_encode(params['oauth_access_token']) if params.has_key?('oauth_access_token')
      params['oauth_signature'] = url_encode(Base64.encode64(OpenSSL::HMAC.digest('sha1', signing_key, base_string)).chomp.gsub(/\n/, ''))
      params['realm'] = "#{url.scheme}://#{url.host}#{url.path}"
      oauth_header = params.collect { |k, v| "#{k}=\"#{v}\"" }.join(", ")
      headers['Authorization'] = "OAuth #{oauth_header}"
      headers
    end

    def prepare_request(path, method, opts = {})
      opts[:headers] = sign_request(method.to_s.upcase, path, opts) unless opts[:unsigned]

      {url: path, method: method, body: opts[:body], headers: opts[:headers]}
    end

    def default_params
      {
          'oauth_consumer_key' => @consumer_key,
          'oauth_nonce' => generate_nonce,
          'oauth_signature_method' => 'HMAC-SHA1',
          'oauth_timestamp' => Time.now.getutc.to_i.to_s,
          'oauth_version' => '1.0'
      }
    end

    def generate_nonce(size=7)
      Base64.encode64(OpenSSL::Random.random_bytes(size)).gsub(/\W/, '')
    end

    def url_encode(string)
      CGI.escape(string)
    end
  end
end