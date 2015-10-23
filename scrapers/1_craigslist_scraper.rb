require 'open-uri'
require 'nokogiri'
require 'csv'

#all the cities that we will be scraping
# list_of_cities = ["bakersfield", "chico", "fresno", "goldcountry", "hanford", "inlandempire", "lasvegas", "losangeles", "mendocino", "merced", "modesto", "mohave", "monterey", "orangecounty", "palmsprings", "redding", "reno", "sacramento", "sandiego", "slo", "santabarbara", "santamaria", "sfbay", "siskiyou", "stgeorge", "stockton", "susanville", "ventura", "visalia", "yubasutter"
# ]

city_name = 'chico'

page =  Nokogiri::HTML(open("http://"+ city_name + ".craigslist.org/search/apa"))

# scraping the dates of the listings
dates = page.css('span.txt .pl time')
date_array = dates.map do |date|
	date.text.strip
end 

# scraping the id
ids = page.css('div.content p.row')
id_array = ids.map do |id|
	id['data-pid']
end

# scraping the title
titles = page.css('span.txt .pl a')
title_array = titles.map do |title|
	title.text
end 


# scraping the prices
prices = page.css('span.txt span.price')
price_array = prices.map do |price|
	price.text.strip
end 


# ###################################
# # 	   Need to split Data here    #
# ###################################
# scraping the br/ sq ft 
housing_array = []
housings = page.css('span.txt span.housing')
housings.each_with_index do |housing, idx|
	new_item_arr = housing.text.gsub(/\/\s+/, "")#.split(/\s+-\s+/)  still working on getting this split right 
	housing_array << new_item_arr
end 


# scraping the general city/ geo area
cities = page.css('span.txt span.pnr small')
city_array = cities.map do |city|
	city.text.gsub(/[()]/, "")
end 

address_array = []
addresses = page.css('div.content span.pnr small')
addresses.each do |address|	
	res = address.text.gsub(/[()]/, "").strip[0]
	if (/[0-9]/ =~ res) != nil
		if (address.text.gsub(/[()]/, "")) == nil
			return 
		else
			address_array << address.text.gsub(/[()]/, "")  
		end
	end
end



CSV.open("craigslist_listings.csv", "w") do |file|
	file << ["Date", "Listing_ID", "Listing_Title", "Price", "Bedrooms", "Square_Ft", "City", 'Address']
	date_array.length.times do |i|
		file << [date_array[i], id_array[i], title_array[i], price_array[i], housing_array[i],  housing_array[i],  city_array[i], address_array[i]]
	end
end


















