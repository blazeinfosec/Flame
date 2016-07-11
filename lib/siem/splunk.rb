class Splunk < Siem::Connector

	attr_reader :username, :password

	def initialize(cli, parser, debug)
		super(cli,debug)
		@cli 		  =  cli
		@debug        =  debug
		@parser	      =  parser
		@source_name  =  cli[:source]
		@username     =  cli[:username]
		@password     =  cli[:password]
		@token        =  cli[:token] 
		@tool		  =  cli[:tool]
		@flame_data   =  Datastore.new().flame_data
		
		@debug.status "\e[36mSplunk\e[0m will be used as SIEM"
		@SESSION = get_session()
		get_event_token()
		build_event()
	end

	def get_session()
		@debug.status "Connecting to Splunk server"
		response = flame_post("/services/auth/login",
                               "username=#{@username}&password=#{@password}")
    	xml_parse = Nokogiri::Slop(response)
    	session = xml_parse.xpath("//sessionKey").text

    	if session == ""
    		@debug.error "Authentication error, please verify your username and password\n"
    		exit
    	else
    		@debug.success "Successfully authenticated"
    		session = { 'Authorization' => " Splunk #{session}" }
    	end

    	return session
	end

	def get_event_token()
		if @token == nil 
			@token = get_current_key()
		else
			@token = { 'Authorization' => " Splunk #{@token}" }
		end

		return @token
	end

	def get_current_key()
		@debug.success "Getting the token value"
		response = flame_get("/services/data/inputs/http/Flame")
		token = Nokogiri::XML(response)

		error = token.xpath("//msg[@type='ERROR']").text

		if error.size > 0 
			token = create_event_collector()
		else
			token = token.xpath("//s:key[@name='token']").text
			token = { 'Authorization' => " Splunk #{token}" }
		end

		return token
	end

	def create_event_collector()
		@debug.success "Token does not exists. Flame will generate a new HTTP Event Collector token"
		token_response = flame_post("/servicesNS/nobody/search/data/inputs/http", 
			                        "name=Flame&source=#{@source_name}")
		token = Nokogiri::XML(token_response)
		token = token.xpath("//s:key[@name='token']").text
		token = { 'Authorization' => " Splunk #{token}" }

		return token
	end

	def build_event()
		events =  @parser.generate_event()
		if events.size == 0 
			@debug.status "The report file contains \e[36m#{events.size} vulnerabilities\e[0m\n"
			exit
		else
			@debug.status "The report file contains \e[36m#{events.size} vulnerabilities\e[0m"
			@debug.status "Flame will send all events to Splunk\n"
		end
		events.each do |event|	
			data = "{\"event\": #{event.to_json}}"
			send_event(data)
			@debug.success "Event: \e[31m#{event[:name]}\e[0m sent successfully"
		end
	end

	def send_event(event)	
		@change_token = true	
		flame_post('/services/collector/event', event, @token)
	end
end