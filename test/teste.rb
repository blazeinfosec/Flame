#!/usr/bin/env ruby

require 'nokogiri'
require 'rexml/document'

@file  = File.open("scans/EH_Externo__Capgemini__src3cc.nessus")
@doc1  = Nokogiri::XML(@file)
#@doc2  = REXML::Document.new(@file)

def parse_nokogiri
	puts @doc1.xpath("//ReportHost").count
	puts @doc1.xpath("/NessusClientData_v2/Report/ReportHost[10]/HostProperties/tag[@name='host-ip']").text
	
	@doc1.xpath("/NessusClientData_v2/Report/ReportHost[10]/ReportItem/plugin_name").each do |vuln|
		puts vuln.text
	end
end

def parse_rexml
	host_amount = @doc2.elements["//ReportHost"].count
	puts host_amount
	@doc2.elements.collect("/NessusClientData_v2/Report/ReportHost") do |issue|
		teste =  issue.elements.collect {|e| e.elements["//tag[@name='host-ip']"].text}
		testes = issue.elements['description']
	end
	# @doc2.elements.collect("//results/result") do |host|
	# 	puts host.elements['plugin_name'].text
	# end

end


parse_rexml