class Configuration

	attr_reader :options

	def initialize(debug)
		@debug    =  debug
		@options  =  Hash.new
  
		@flame_data = Datastore.new().flame_data
	end
	
	def banner
		@debug.status "Flame - Send vulnerabilities scanners reports to SIEM"
		
	end

	def cli_required(options)
		# Validate if the required parameters were defined
		begin
  			required = [:username, :password, :server, :tool, :file, :siem]
  			missing = required.select do |param| 
  				options[param].nil? 
  			end

  			unless missing.empty?                                            
    			@debug.error "Missing required options: #{missing.join(', ')}\n"                                                                
    			exit                                                         
  			end
		rescue OptionParser::InvalidOption, OptionParser::MissingArgument
  			puts $!.to_s
  			exit
		end  		

		return options		
	end
	
	def cli_parser()
		# Parse command line arguments
		ARGV << '-h' if ARGV.empty?

		OptionParser.new do |opts|
			opts.banner = banner()

			@options[:file] = nil
    		opts.on("-f", "--file", "Vulnerability scanner report file (required)") do
    			@options[:file] = ARGV[0]
   		 	end

			@options[:tool] = nil
    		opts.on("-n", "--tool-name", "Scanner tool name. Current available tools: \e[36m#{@flame_data[:tools].join(", ")}\e[0m (required)") do
    			@options[:tool] = ARGV[0].capitalize
   		 	end

   		@options[:proxy] = nil
    	 opts.on("--proxy", "Use HTTP proxy to connect to target SIEM, ex: http://127.0.0.1:8080") do
    		  @options[:proxy] = ARGV[0]
   		 end

   		@options[:siem] = nil
    	 opts.on("--siem", "SIEM to connect. Current available SIEMs: \e[36m#{@flame_data[:siem].join(", ")}\e[0m \n\n") do
    		  @options[:siem] = ARGV[0].capitalize
   		 end

   		opts.separator " Splunk options:"
   		opts.separator "   Configure Splunk sepecif environment\n\n"

			@options[:username] = nil
    	 opts.on("-u", "--username", "Splunk username (required)") do
    			@options[:username] = ARGV[0]
   		 end

			@options[:password] = nil
    	 opts.on("-p", "--password", "Splunk password (required)") do
    			@options[:password] = ARGV[0]
   		 end

    	@options[:server] = nil
    	 opts.on("-s", "--server", "Splunk ip address or hostname (required)") do
     			@options[:server] = ARGV[0]
    	end

    	@options[:port] = 8089
    	 opts.on("-t", "--port", "Splunk TCP port (default 8089)") do
     			@options[:port] = ARGV[0]
    	end

    	@options[:token] = nil
    	 opts.on("--token", "Splunk HTTP event collector token. If no token be specified, Flame will generate a new") do
     		 @options[:token] = ARGV[0]
    	end

			@options[:source] = 'Flame'
    	 opts.on("--source", "Specify a source name to be used in Splunk (default is Flame)\n\n") do
    			@options[:source] = ARGV[0]
   		 end
    end.parse!

		cli_required(@options)
	end	
end