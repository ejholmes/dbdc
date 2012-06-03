module Dbdc
  class Client

    def initialize(options={})
      @options = {
        :username => Dbdc.configuration.username,
        :password => Dbdc.configuration.password,
        :host     => Dbdc.configuration.host
      }.merge(options) if options.is_a?(Hash)
    end

    def authenticate(credentials={})
    end

  end
end
