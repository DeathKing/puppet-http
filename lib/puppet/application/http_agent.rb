require 'puppet/patch'
require 'puppet/application/agent'

class Puppet::Application::HttpAgent < Puppet::Application::Agent

  def wait_for_certificates
    # Logging is necessary to aware user they are currently using an unsafe transmission.
    Puppet.debug "Puppet HTTPAgent won't fetch certificate."
  end

  def fingerprint
    raise RuntimeError, "HTTPAgent has no fingerprint."
  end

end