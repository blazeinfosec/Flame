RUBY_LIBS = [
				'uri',
				'json',
				'optparse',
				'nokogiri',
				'net/https',
				'rexml/document'
			 ]

FLAME_LIBS = [
				'lib/debug/',
				'lib/common/',
				'lib/siem/',
			 ]

class Environment

	def initialize()
		ruby_libraries()
		flame_libraries()
		plugins_libraries()
	end

	def ruby_libraries()
		RUBY_LIBS.each do |file|
			require file
		end

	end

	def plugins_libraries()
		plugins = Dir[File.join(PATH, 'plugins', '*.rb')]

		plugins.each do |file| 
  			require file
  		end
  	end

	def flame_libraries()	
		FLAME_LIBS.each do |dir|
			Dir[File.join(PATH, "#{dir}", '*.rb')].each do |file| 
				require file
			end
		end
	end
end

class Start
	def initialize(data, config, debug)
		@flame_data  =  data
		@config      =  config
		@debug       =  debug

		start_flame()
	end

  	def load_parser()
    	parse = {
      		:xml   => Kernel.const_get("#{@config[:tool]}::Xml"), 
      		:html  => Kernel.const_get("#{@config[:tool]}::Html")
    	}

    	if File.extname(@config[:file]) == ".xml"
      		parser =  parse[:xml].new(@config,@debug)
    	elsif File.extname(@config[:file]) == ".html"
      		parser =  parse[:html].new(@config,@debug)
    	else
      		@debug.error "The provided file format is not valid. Current supported file formats: #{@flame_data[:formats].join(", ")}\n"
      		exit
    	end

    	return parser
  	end

	# Verify the scanner provided  
	def check_tools
		if !@flame_data[:tools].include?(@config[:tool])
			@debug.error "The provided tool (#{@config[:tool]}), it is not currently supported. Current tools supported: #{@flame_data[:tools].join(", ")}\n"
			exit
		end
	end

	# Call SIEM and start to send data
	def start_flame()
		check_tools()

		parser  = load_parser()
		if @flame_data[:siem].include?(@config[:siem])
			siem = Kernel.const_get("#{@config[:siem]}")
			siem = siem.new(@config,parser,@debug)
		else
			@debug.error "The provided SIEM (#{@config[:siem]}), it is not currently supported. Current supported SIEM: #{@flame_data[:siem]
					 .join(", ")}\n"
			exit
		end

		@debug.status "Thanks for using Flame :)\n"
	end
end