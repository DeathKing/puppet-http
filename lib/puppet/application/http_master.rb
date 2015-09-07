require 'puppet/patch'
require 'puppet/application/master'

class Puppet::Application::HttpMaster < Puppet::Application::Master

  def setup_ssl
    # Logging is necessary to make user aware of they are currently using an unsafe transmission.
    Puppet.debug "Puppet HTTPMaster won't setup SSL environment."
  end

  def main
    require 'etc'

    if Puppet.features.root?
      begin
        Puppet::Util.chuser
      rescue => detail
        Puppet.log_exception(detail, "Could not change user to #{Puppet[:user]}: #{detail}")
        exit(39)
      end
    end

    if options[:rack]
      start_rack_master
    else
      start_webrick_master
    end
  end

  def start_webrick_master
    require 'puppet/patch/webrick'
    super
  end

end