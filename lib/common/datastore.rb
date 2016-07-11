class Datastore

	def initialize()
		@remove  =  [".", "..", "connector.rb"]

	end

	def flame_data
		@flame = { 
			:version  =>  '1.0',
			:name     =>  'Flame',
			:autor    =>  'Tiago Ferreira <tiago at blazeinfosec.com>',
			:formats  =>  ['.html', '.xml'],
			:siem     =>  get_supported_siem(),	
			:tools    =>  get_supported_tools()
		}
		return @flame
	end

	def get_supported_tools()
		tools = []
		Dir.foreach("plugins") do |name|
			if !@remove.include?(name)
				tools << name.gsub(/\.rb/,"").capitalize
			end
		end

		return tools
	end

	def get_supported_siem()
		siem = []
		Dir.foreach("lib/siem") do |name|
			if 	!@remove.include?(name)
				siem << name.gsub(".rb","").capitalize
			end
		end

		return siem
	end
end