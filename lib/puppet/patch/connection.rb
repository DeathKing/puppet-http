require 'puppet/network/http/connection'

module Puppet::Network::HTTP
  class HTTPConnection < Connection

    def initialize(host, port, options = {})
      verify = Puppet::SSL::Validator.no_validator()
      super(host, port, options.merge(:use_ssl => false, :verify => verify))
    end

  end
end
