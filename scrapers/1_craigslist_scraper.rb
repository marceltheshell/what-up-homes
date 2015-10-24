require 'open-uri'
require 'nokogiri'
require 'csv'

#all the cities that we will be scraping
# list_of_cities = ["bakersfield", "chico", "fresno", "goldcountry", "hanford", "inlandempire", "lasvegas", "losangeles", "mendocino", "merced", "modesto", "mohave", "monterey", "orangecounty", "palmsprings", "redding", "reno", "sacramento", "sandiego", "slo", "santabarbara", "santamaria", "sfbay", "siskiyou", "stgeorge", "stockton", "susanville", "ventura", "visalia", "yubasutter"
# ]

city_name = 'chico'

page =  Nokogiri::HTML(open("http://"+ city_name + ".craigslist.org/search/apa"))
# scraping the addresses
address_array = []
addresses = page.css('div.content span.pnr small')
addresses.each do |address|	
	res = address.text.gsub(/[()]/, "").strip[0]
	if (/[0-9]/ =~ res) != nil
		if (address.text.gsub(/[()]/, "")) == nil
			address_array << " "
		else
			address_array << address.text.gsub(/[()]/, "").strip
		end
	else
		address_array << " "
	end
end

# scraping the dates of the listings
dates = page.css('span.txt .pl time')
date_array = dates.map do |date|
	date.text.strip
end 

# scraping the id
ids = page.css('div.content p.row')
id_array = ids.map do |id|
	id['data-pid'].strip
end

# scraping the title
titles = page.css('span.txt .pl a')
title_array = titles.map do |title|
	title.text.strip
end 


# scraping the prices
prices = page.css('span.txt span.price')
price_array = prices.map do |price|
	price.text.gsub(/[$]/, "")
end 

# scraping the br/ sq ft 
bedrooms_array = []
sqft_array = []
temp = ""
housings = page.css('span.txt span.housing')
housings.each_with_index do |housing, idx|
	temp = housing.text.gsub(/\/\s+/, "").split(/\s+-\s+/)
	if (/br/ =~ temp[0]) != nil
		bedrooms_array << temp[0].gsub(/br/, "").strip
	else
		bedrooms_array << " "
	end
	if (/[0-9]/ =~ temp[1]) != nil
		sqft_array << temp[1].gsub(/ft2/, "").strip
	else
		sqft_array << " "
	end
end 

# scraping the general city/ geo area
cities = page.css('span.txt span.pnr small')
city_array = cities.map do |city|
	city.text.gsub(/[()]/, "").strip
end 

CSV.open("craigslist_listings_wuh.csv", "w") do |file|
	# file << ["Address", "Date", "Listing_ID", "Listing_Title", "Price", "Bedrooms", "Square_Ft", "City"]
	date_array.length.times do |i|
		file << [address_array[i], date_array[i], id_array[i], title_array[i], price_array[i], bedrooms_array[i],  sqft_array[i],  city_array[i]]
	end
end


















