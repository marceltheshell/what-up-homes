require 'open-uri'
require 'nokogiri'
require 'csv'

#all the cities that we will be scraping
list_of_cities = ["bakersfield" # "chico", "fresno", "goldcountry", "hanford", "inlandempire", "lasvegas", "losangeles", "mendocino", "merced", "modesto", "mohave", "monterey", "orangecounty", "palmsprings", "redding", "reno", "sacramento", "sandiego", "slo", "santabarbara", "santamaria", "sfbay", "siskiyou", "stgeorge", "stockton", "susanville", "ventura", "visalia", "yubasutter"
]

#all the empty arrays to populate and push into CSV
date_array = []
id_array = []
latlon_array = []
address_array = []
title_array = []
price_array = []
housing_array = []
new_item_arr = [] #when you clean up data, double check if this is necessary
city_array = []


list_of_cities.each do |city_name|

	page =  Nokogiri::HTML(open("http://"+ city_name + ".craigslist.org/search/apa"))

	# scraping the dates of the listings
	dates = page.css('span.txt .pl time')
	dates.each do |date|
		date_array << date.text.strip
	end 

	# scraping the id
	ids = page.css('div.content p.row')
	ids.each do |id|
		formatted_id = id['data-pid']
		puts formatted_id
		id_array << formatted_id

		show_page = Nokogiri::HTML(open('http://' + city_name + '.cragislist.org/apa/' + formatted_id + '.html'))
		
		#scraping the latlon
		latlons = page.css('section.body div#map')
		latlons.each do |latlon|
			puts latlon
			lattitude = latlon['data-latitude']
			longitude = latlon['data-longitude']
			latlon_array = [lattitude, longitude]
		end

		#scraping the address
		addresses = page.css('section.body div.mapaddress')
		addresses.each do |address|
			puts address
			address_array << address.text
		end
	end

	puts latlon_array
	puts address_array


	# scraping the title
	titles = page.css('span.txt .pl a')
	titles.each do |title|
		title_array << title.text
	end 


	# scraping the prices
	prices = page.css('span.txt span.price')
	prices.each do |price|
		price_array << price.text.strip
	end 


	# ###################################
	# # 	   Need to split Data here    #
	# ###################################
	# scraping the br/ sq ft 
	housings = page.css('span.txt span.housing')
	housings.each_with_index do |housing, idx|
		new_item_arr = housing.text.gsub(/\/\s+/, "")#.split(/\s+-\s+/)  still working on getting this split right 
		housing_array << new_item_arr
	end 


	# scraping the general city/ geo area
	cities = page.css('span.txt span.pnr small')
	cities.each do |city|
		city_array << city.text.gsub(/[()]/, "")
	end 



	CSV.open("craigslist_listings.csv", "a") do |file|
		file << ["Date", "Listing_ID", "Listing_Title", "Price", "Bedrooms", "Square_Ft", "City"]
		date_array.length.times do |i|
			file << [date_array[i], id_array[i], title_array[i], price_array[i], housing_array[i],  housing_array[i],  city_array[i] ]
		end
	end
end

















