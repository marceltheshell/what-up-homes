require 'open-uri'
require 'nokogiri'
require 'csv'

#all the cities that we will be scraping
region_name = ["bakersfield", "chico", "fresno", "goldcountry", "hanford", "inlandempire", "lasvegas", "losangeles", "mendocino", "merced", "modesto", "mohave", "monterey", "orangecounty", "palmsprings", "redding", "reno", "sacramento", "sandiego", "slo", "santabarbara", "santamaria", "sfbay", "siskiyou", "stgeorge", "stockton", "susanville", "ventura", "visalia", "yubasutter"
]

region_name.each do |region|
	# write change name logic here

	page =  Nokogiri::HTML(open("http://"+ region + ".craigslist.org/search/apa"))
	
	# scraping the addresses
	address_array = []
	city_array = []
	addresses = page.css('div.content span.pnr small')
	addresses.each do |address|	
		#delete the parenthesis/whitespace and take the first character
		res = address.text.gsub(/[()]/, "").strip
		#if the first character of the address is a number 
		#puts res

		if (/[0-9]/ =~ res[0]) != nil
			address_array << res
			# plug in the region name into the city
			city_array << region
		else
			# put blank space into address
			temp = res.split
			city_array << temp[0] 
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

	#adding state to the array
	state_array = []
	date_array.length.times do 
		state_array << 'California'
	end

	#adding cl_region
	cl_region_array = []
	date_array.length.times do 
		cl_region_array << region
	end

	CSV.open("craigslist_listings_wuh.csv", "a") do |file|
		# file << ["Address", "Date", "Listing_ID", "Listing_Title", "Price", "Bedrooms", "Square_Ft", "City", "State", "CL_region", "Zip_code"]
		date_array.length.times do |i|
			file << [address_array[i], date_array[i], id_array[i], title_array[i], price_array[i], bedrooms_array[i],  sqft_array[i],  city_array[i], state_array[i], cl_region_array[i]]
		end
	end
end






