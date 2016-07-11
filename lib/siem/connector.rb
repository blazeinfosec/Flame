module Siem
	class Connector

		attr_reader   :host, :port, :ssl, :port_event, :debug, :proxy
		attr_accessor :event

		def initialize(cli, debug)
			@debug         =  debug
			@port_event    =  8088
			@ssl           =  true
			@change_token  =  false
			@host	       =  cli[:server]
			@port	       =  cli[:port]
			p_url	       =  cli[:proxy]

			@proxy 	     = URI.parse(p_url) if p_url && !p_url.nil?

		end

		def flame_request()
			begin
				if @change_token and @proxy
					connect = Net::HTTP.new(@host, @port_event, @proxy.host, @proxy.port)
				elsif @change_token
					connect = Net::HTTP.new(@host, @port_event)
				elsif @proxy
					connect = Net::HTTP.new(@host, @port, @proxy.host, @proxy.port)
				else
					connect = Net::HTTP.new(@host, @port)
				end
				connect.use_ssl = @ssl if @ssl
				connect.verify_mode = OpenSSL::SSL::VERIFY_NONE
		
			rescue Exception => e
				@debug.error "Something went wrong with your request: \n\n#{e}"
				exit
			end

			return connect
		end

		def flame_get(path)
			flame_request.get(path, @SESSION).body
		end

		def flame_post(path, data, token=nil)
			if @change_token
				flame_request.post(path, data, token).body
			else
				flame_request.post(path, data, @SESSION).body
			end
		end
		
	end
end
