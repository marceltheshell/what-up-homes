require 'open-uri'
require 'nokogiri'
require 'csv'

url = "https://www.airbnb.com/s/Brooklyn--NY--United-States"

page = Nokogiri::HTML(open(url))

name = []
listings = page.css('h3.h5.listing-name')
listings.each do |listing|
	name << listing.text.strip
end


price = []
prices = page.css('span.h3.price-amount')
prices.each do |cost|
	price << cost.text.strip
end


details = []
rooms = page.css('div.text-muted.listing-location.text-truncate')
rooms.each do |room|
	details << room.text.gsub(/\s+/, "").split(/··/)
end


CSV.open("airbnb_listings.csv", "w") do |file|
	file << ["Listing Name", "Price", "Details", "Room_type", "Reviews"]
	name.length.times do |i|
		file << [name[i], price[i], details[i][0], details[i][1]]
	end
end





