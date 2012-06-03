module Dbdc
  class Client
    attr_reader :access_token

    def initialize(options={})
      @options = {
        :username       => Dbdc.configuration.username,
        :password       => Dbdc.configuration.password,
        :security_token => Dbdc.configuration.security_token,
        :client_id      => Dbdc.configuration.client_id,
        :client_secret  => Dbdc.configuration.client_secret,
        :host           => Dbdc.configuration.host,
        :api_version    => Dbdc.configuration.api_version
      }.merge(options) if options.is_a?(Hash)
    end

    def authenticate
      response = connection.post do |request|
        request.url '/services/oauth2/token'
        request.params = {
          :grant_type    => 'password',
          :client_id     => @options[:client_id],
          :client_secret => @options[:client_secret],
          :username      => @options[:username],
          :password      => "#{@options[:password]}#{@options[:security_token]}"
        }
      end

      raise Dbdc::Error, response.body["error"] if response.status != 200
      @access_token = response.body
      @options[:host] = @access_token['instance_url'].gsub(/https:\/\//, '')
      @connection = nil
    end

    def list_sobjects
      describe_sobjects.collect { |sobject| sobject['name'] }
    end

    def describe_sobjects(force_request=false)
      response = connection.get "/services/data/v#{@options[:api_version]}/sobjects"
      if force_request
        @sobjects = response.body['sobjects']
      else
        @sobjects ||= response.body['sobjects']
      end
    end

  private

    def connection
      @connection ||= Faraday.new(:url => "https://#{@options[:host]}") do |builder|
        builder.request  :json
        builder.response :json
        builder.response :logger if Dbdc.log?
        builder.adapter Faraday.default_adapter
      end
      @connection.headers['Authorization'] = "OAuth #{@access_token['access_token']}" if @access_token
      @connection
    end

  end
end
