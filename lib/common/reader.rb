class Reportfile

	def initialize(cli, debug)
		@debug  			=  debug
		@file   			=  cli[:file]
		@flame_data         =  Datastore.new().flame_data
		@current_formats 	=  @flame_data[:formats]
	
	end
	
	def read_file()
		@debug.status "Loading scanner file \e[36m#{@file}\e[0m"

		if File.exist?(@file)
			file_report = load_file()
			@debug.success "File was successfuly loaded"
		else
			@debug.error "The file #{@file} does not exist in the current path.\n"
			exit
		end

		return file_report		
	end

	def load_file()
		format = detect_file_format()
		file = File.open(@file,'r')

		return file
	end

	def detect_file_format()
		extension = File.extname(@file)
		@debug.success "The format loaded is #{extension}"

		if @current_formats.include?(File.extname(@file))
			file_format = extension
		else
			@debug.error "The provided file format is not currently supported. Please give a file with the folowing formats: #{@current_formats.join(", ")}\n"
			exit
		end

		return file_format
	end
end