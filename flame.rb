#!/usr/bin/env ruby
# Flame v1.0 - xxx xxxxx
# Developed by Tiago Ferreira - Security Engineering (tiago at blazeinfosec dot com)
# Blaze Information Security - https://www.blazeinfosec.com/ - https://blog.blazeinfosec.com
 
PATH = File.dirname(__FILE__)
require File.join(PATH, 'environment')

# Load plugins
Environment.new()

# Start debug methods
@debug = Debug::Output.new()

# Load parameters (CLI)
@config = Configuration.new(@debug).cli_parser()

# Load environment details 
@flame_data = Datastore.new().flame_data

# Start SIEM connection
Siem::Connector.new(@config, @debug) 

# Load report
Reportfile.new(@config, @debug)

# Start Flame
Start.new(@flame_data, @config, @debug)