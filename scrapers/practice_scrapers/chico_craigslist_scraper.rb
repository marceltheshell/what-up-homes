require 'open-uri'
require 'nokogiri'
require 'csv'

url = 'http://chico.craigslist.org/search/apa'
page = Nokogiri::HTML(open(url))

address_array = []
addresses = page.css('div.content span.pnr small')
addresses.each do |address|	
	res = address.text.gsub(/[()]/, "").strip[0]
	if (/[0-9]/ =~ res) != nil
		if (address.text.gsub(/[()]/, "")) == nil
			address_array << nil 
		else
			address_array << address.text.gsub(/[()]/, "")  
		end
	else
		address_array << nil
	end
end

puts address_array

