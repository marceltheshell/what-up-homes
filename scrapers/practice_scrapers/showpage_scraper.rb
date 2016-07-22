require 'open-uri'
require 'nokogiri'
require 'csv'




url = 'https://sfbay.craigslist.org/eby/apa/5278726808.html'
page = Nokogiri::HTML(open(url))

latlon_array = []
address_array = []


latlons = page.css('section.body div#map')
latlons.each do |latlon|
	lattitude = latlon['data-latitude']
	longitude = latlon['data-longitude']
	latlon_array = [lattitude, longitude]
end
puts latlon_array

# addresses = page.css('section.body div.mapaddress')
# addresses.each do |address|
# 	address_array << address.text
# end






# address_array << page.css()
