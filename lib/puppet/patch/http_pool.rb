require 'puppet/network/http_pool'
require 'puppet/patch/connection'

module Puppet::Network::HttpPool

  # Ya, this is a magic trick yet to be dangerous. Be very careful because this might infect
  # both self.http_instance and self.http_ssl_instance. After execute this code, that two
  # methods both return a HTTP connection in any condition.
  @http_client_class = Puppet::Network::HTTP::HTTPConnection

end