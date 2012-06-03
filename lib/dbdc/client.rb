module Dbdc
  class Client

    def initialize(options={})
      @options = {
        :username       => Dbdc.configuration.username,
        :password       => Dbdc.configuration.password,
        :security_token => Dbdc.configuration.security_token,
        :client_id      => Dbdc.configuration.client_id,
        :client_secret  => Dbdc.configuration.client_secret,
        :host           => Dbdc.configuration.host
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
    end

  private

    def connection
      @connection ||= Faraday.new(:url => "https://#{@options[:host]}") do |builder|
        builder.request  :json
        builder.response :json
        builder.response :logger if Dbdc.log?
        builder.adapter Faraday.default_adapter
      end
    end

  end
end
