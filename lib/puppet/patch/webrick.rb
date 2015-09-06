require 'puppet/network/http/webrick'

class Puppet::Network::HTTP::WEBrick

  def listen(address, port)
    @server = create_server(address, port)

    # @server.listeners.each { |l| l.start_immediately = false }

    @server.mount('/', Puppet::Network::HTTP::WEBrickREST)

    raise "WEBrick server is already listening" if @listening
    @listening = true
    @thread = Thread.new do
      @server.start do |sock|
        timeout = 10.0
        if ! IO.select([sock],nil,nil,timeout)
          raise "Client did not send data within %.1f seconds of connecting" % timeout
        end
        # sock.accept
        @server.run(sock)
      end
    end
    sleep 0.1 until @server.status == :Running
  end

  def create_server(address, port)
    arguments = {:BindAddress => address, :Port => port, :DoNotReverseLookup => true}
    arguments.merge!(setup_logger)
    # arguments.merge!(setup_ssl)

    BasicSocket.do_not_reverse_lookup = true

    server = WEBrick::HTTPServer.new(arguments)
    # server.ssl_context.ciphers = CIPHERS
    server
  end

end