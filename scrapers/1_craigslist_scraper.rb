require 'open-uri'
require 'nokogiri'
require 'csv'

#all the cities that we will be scraping
usa_region_name = [
		['sfbay', 'CA'],
		['elko', 'Nevada'],
		['elmira', 'NY', 'elmira corning'],
		['elpaso', 'TX']
		['erie', 'PA'],
		['eugene', 'OR'],
		['evansville', 'IN'],
		['fairbanks', 'AK'],
		['fargo', 'ND', 'fargo moorhead'],
		['farmington', 'NM'],
		['fayar', 'AR'],
		['fayetteville', 'NC'],
		['fingerlakes', 'NY'],
		['flagstaff', 'AZ'],
		['flint', 'Michigan'],
		['shoals', 'Alabama', 'florence muscle shoals'],
		['florencesc', 'SC'],
		['keys', 'FL', 'florida keys'],
		['fortcollins', 'CO' ,'fort collins north CO'],
		['fortdodge', 'Iowa'],
		['fortsmith', 'AR'],
		['fortwayne', 'Indiana'],
		['frederick', 'MD'],
		['fredericksburg', 'VA'],
		['fresno', 'CA'],
		['fortmyers', 'FL'],
		['gadsden', 'AL'],
		['gainesville', 'FL'],
		['galveston', 'TX'],
		['glensfalls', 'NY'],
		['goldcountry', 'CA'],
		['grandforks', 'ND'],
		['grandisland', 'Nebraska'],
		['grandrapids', 'MI'],
		['greatfalls', 'Montana'],
		['greenbay', 'WI'],
		['greensboro', 'NC'],
		['greenville', 'SC'],
		['gulfport', 'MI', 'gulfport biloxi'],
		['norfolk', 'VA', 'hampton roads'],
		['hanford', 'WA'],
		['harrisburg', 'PA'],
		['harrisonburg', 'VA'],
		['hartford', 'CT'],
		['hattiesburg', 'MS'],
		['honolulu', 'HI'],
		['cfl', 'FL', 'heartland florida'],
		['helena', 'MT'],
		['hickory', 'NC'],
		['rockies', 'CO'],
		['hiltonhead', 'SC'],
		['holland', 'MI'],
		['houma', 'LA'],
		['houston', 'TX'],
		['hudsonvalley', 'NY'],
		['humboldt', 'CA'],
		['huntington', 'WV', 'huntington ashland'],
		['huntsville', 'IL', 'huntsville decatur'],
		['imperial', 'CA',  'imperial county'],
		['indianapolis', 'Indiana'],
		['inlandempire', 'CA', 'riverside san bernardino'],
		['iowacity', 'IA'],
		['ithaca', 'NY'],
		['jxn', 'MI', 'jackson MI'],
		['jackson', 'MS'],
		['jacksontn', 'TN'],
		['jacksonville', 'FL'],
		['onslow', 'NC', 'jacksonville NC'],
		['janesville', 'WI'],
		['jerseyshore', 'NJ'],
		['jonesboro', 'AK'],
		['joplin', 'MO'],
		['kalamazoo', 'Michigan'],
		['kalispell', 'MT'],
		['kansascity', 'MO'],
		['kenai', 'AK'],
		['kpr', 'WA', 'kennewick pasco richland'],
		['racine', 'WI', 'kenosha racine'],
		['killeen', 'TX', 'temple fort hood'],
		['kirksville', 'MO'],
		['klamath', 'OR'],
		['knoxville', 'TN'],
		['kokomo', 'IN'],
		['lacrosse', 'WI'],
		['lafayette', 'LA'],
		['tippecanoe', 'IN', 'lafayette west lafayette'],
		['lakecharles', 'LA'],
		['lakeland', 'FL'],
		['loz', 'lake of the ozarks'],
		['lancaster', 'PA'],
		['lansing', 'MI'],
		['laredo', 'TX'],
		['lasalle', 'IL'],
		['lascruces', 'NM'],
		['lasvegas', 'NV'],
		['lawrence', 'MA'],
		['lawton', 'OK'],
		['allentown', 'PA', 'lehigh valley'],
		['mobile', 'AL'],
		['montgomery', 'AL'],
		['tuscaloosa', 'AL'],
		['mattoon', 'AL'], 
		['peoria', 'IL'],
		['rockford', 'AL'],
		['carbondale', 'AL'],
		['springfieldil', 'AL', 'springfield'], 
		['quincy', 'AL'],
		['missoula', 'MT'], 
		['providence', 'RI'], 
		['myrtlebeach', 'SC'], 
		['juneau', 'AK'],
		['northplatte', 'NE', 'north platte'],
		['omaha', 'NE'],
		['scottsbluff', 'NE'], 
		['nesd', 'SD', 'Sioux Falls']
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
	sleep 3
	
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

	CSV.open("ccc_practice", "w") do |file|
		date_array.length.times do |i|
			file << [address_array[i], date_array[i], id_array[i], title_array[i], price_array[i], bedrooms_array[i],  sqft_array[i],  city_array[i], state_array[i], cl_region_array[i]]
		end
	end
end




# file << ["Address", "Date", "Listing_ID", "Listing_Title", "Price", "Bedrooms", "Square_Ft", "City", "State", "CL_region", "Zip_code"]


# CA_region_name = ["bakersfield", "chico", "fresno", "goldcountry", "hanford", "inlandempire", "lasvegas", "losangeles", "mendocino", "merced", "modesto", "mohave", "monterey", "orangecounty", "palmsprings", "redding", "reno", "sacramento", "sandiego", "slo", "santabarbara", "santamaria", "sfbay", "siskiyou", "stgeorge", "stockton", "susanville", "ventura", "visalia", "yubasutter"
# ]

# file << ["#{address_array[i]} | #{date_array[i]} | #{id_array[i]} | #{title_array[i]} | #{price_array[i]} | #{bedrooms_array[i]} | #{sqft_array[i]} | #{city_array[i]} | #{state_array[i]} | #{cl_region_array[i]}"]




