require 'open-uri'
require 'nokogiri'
require 'csv'

#all the cities that we will be scraping
usa_region_name = [
		['pittsburgh', 'PA'], 
		['poconos', 'PA'], 
		['reading', 'PA'], 
		['scranton', 'PA'], 
		['pennstate', 'PA', 'State College'], 
		['williamsport', 'PA'], 
		['york', 'PA'], 
		['lubbock', 'TX'], 
		['mcallen', 'TX'], 
		['odessa', 'TX'], 
		['sanangelo', 'TX', 'san angelo'], 
		['sanantonio', 'TX', 'san antonio'], 
		['sanmarcos', 'TX', 'san marcos'], 
		['bigbend', 'TX', 'Texas'], 
		['texoma', 'TX'], 
		['easttexas', 'TX', 'tyler'], 
		['victoriatx', 'TX', 'victoria'], 
		['waco', 'TX'], 
		['wichitafalls', 'TX', 'wichita falls'], 
		['logan', 'UT'], 
		['ogden', 'UT'], 
		['provo', 'UT'], 
		['saltlakecity', 'UT', 'salt lake city'], 
		['burlington', 'VT'], 
		['lynchburg', 'VA'], 
		['blacksburg', 'VA'], 
		['richmond', 'VA'], 
		['roanoke', 'VA'], 
		['swva', 'VA', 'Virginia'], 
		['winchester', 'VA'], 
		['moseslake', 'WA', 'moses lake'], 
		['olympic', 'WA', 'Washington'], 
		['pullman', 'WA'], 
		['seattle', 'WA'], 
		['skagit', 'WA'], 
		['spokane', 'WA'], 
		['wenatchee', 'WA'], 
		['yakima', 'WA'], 
		['morgantown', 'WV'], 
		['wheeling', 'WV'], 
		['parkersburg', 'WV'], 
		['swv', 'WV', 'West Virginia'], 
		['wv', 'WV', 'West Virginia'],
		['madison', 'WI'],  
		['milwaukee', 'WI'],  
		['northernwi', 'WI', 'Wisconsin'],  
		['sheboygan', 'WI'],  
		['wausau', 'WI'],  
		['wyoming', 'WY'], 
		['utica', 'NY'], 
		['watertown', 'NY'], 
		['outerbanks', 'NC', 'outer banks'], 
		['raleigh', 'NC'], 
		['wilmington', 'NC'], 
		['winstonsalem', 'NC', 'winston salem'], 
		['nd', 'ND', 'north dakota'], 
		['limaohio', 'OH', 'lima'], 
		['mansfield', 'OH'], 
		['sandusky', 'OH'], 
		['toledo', 'OH'], 
		['tuscarawas', 'OH'], 
		['youngstown', 'OH'], 
		['zanesville', 'OH'], 
		['enid', 'OK'], 
		['oklahomacity', 'OK', 'oklahoma city'], 
		['stillwater', 'OK', 'still water'], 
		['tulsa', 'OK'], 
		['medford', 'OR'], 
		['oregoncoast', 'OR', 'Oregon'], 
		['portland', 'OR'], 
		['salem', 'OR'], 
		['roseburg', 'OR'], 
		['meadville', 'PA'], 
		['philadelphia', 'PA'], 
		['minneapolis', 'MN'], 
		['rmn', 'MN', 'rochester'], 
		['marshall', 'MN'], 
		['stcloud', 'MN', 'st cloud'], 
		['meridian', 'MS'], 
		['northmiss', 'MS', 'Mississippi'], 
		['natchez', 'MS'], 
		['semo', 'MO', 'Missouri'], 
		['springfield', 'MO'], 
		['stjoseph', 'MO'], 
		['stlouis', 'MO'], 
		['longisland', 'NY'], 
		# ['newyork', 'NY', 'new york'], 
		['oneonta', 'NY'], 
		['plattsburgh', 'NY'], 
		['potsdam', 'NY'], 
		['rochester', 'NY'], 
		['syracuse', 'NY'], 
		['twintiers', 'NY', 'twin tiers'],
	]

##########################################
########for demonstration purposes #######
##########################################
# address_array = [] 
# date_array = [] 
# id_array = []
# title_array = [] 
# price_array = []
# bedrooms_array = []  
# sqft_array = []  
# city_array = [] 
# state_array = []
# cl_region_array = []
##########################################
########for demonstration purposes #######
##########################################

usa_region_name.each do |region|
	page =  Nokogiri::HTML(open("http://"+ region[0] + ".craigslist.org/search/apa"))
	
	#tells the program to sleep for x seconds
	sleep 5
	
	# scraping the addresses
	address_array = []
	city_array = []
	addresses = page.css('div.content span.pnr small')
	addresses.each do |address|	
		#delete the parenthesis/whitespace and call it res
		res = address.text.gsub(/[()]/, "").strip
		
		#if the first character of res IS a number
		if (/[0-9]/ =~ res[0]) != nil
			#res is an address so push it into address_array
			address_array << res
			
			
			###########################################
			# to improve: make a 3rd element in region 
			# array which is more geocoding friendly, and 
			# push that into city_array below
			###########################################
			
			#regex strips any commas and quotes then uses the CL region name for the city
			city_array << region[0].gsub(/[",]/, "").strip
		
		#if the first character of res IS NOT a number
		else
			#split that sentence along commas (if there are any) and call it temp
			temp = res.split
			#regex clean any commas out of temp and push it into city_array
			city_array << temp[0].gsub(/,/, "").strip 
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
		state_array << region[1]
	end

	#adding cl_region
	cl_region_array = []
	date_array.length.times do 
		cl_region_array << region[0]
	end

	CSV.open("aaa_craigslist_listings_wuh.csv", "a") do |file|
		# file << ["Address", "Date", "Listing_ID", "Listing_Title", "Price", "Bedrooms", "Square_Ft", "City", "State", "CL_region", "Zip_code"]
		date_array.length.times do |i|
			file << [address_array[i], date_array[i], id_array[i], title_array[i], price_array[i], bedrooms_array[i],  sqft_array[i],  city_array[i], state_array[i], cl_region_array[i]]
		end
	end
end





# CA_region_name = ["bakersfield", "chico", "fresno", "goldcountry", "hanford", "inlandempire", "lasvegas", "losangeles", "mendocino", "merced", "modesto", "mohave", "monterey", "orangecounty", "palmsprings", "redding", "reno", "sacramento", "sandiego", "slo", "santabarbara", "santamaria", "sfbay", "siskiyou", "stgeorge", "stockton", "susanville", "ventura", "visalia", "yubasutter"
# ]






 