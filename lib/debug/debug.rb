module Debug
	class Output
		attr_accessor :message

		def success(message)
			puts "\s\s[+] #{message}\n"
		end

		def status(message)
			puts "\n[*] #{message}\n"
		end

		def error(message)
			puts "\s\s\e[31m[-] CRITICAL: #{message}\n\e[0m"
		end
	end
end