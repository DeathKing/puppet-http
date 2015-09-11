require 'puppet/application/agent'
require 'puppet/patch'

class Puppet::Application::HttpAgent < Puppet::Application::Agent

  def wait_for_certificates
    # Logging is necessary to make user aware of they are currently using an unsafe transmission.
    Puppet.debug "Puppet HTTPAgent won't fetch certificate."
  end

  def fingerprint
    raise RuntimeError, "HTTPAgent has no fingerprint."
  end

end