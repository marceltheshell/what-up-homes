namespace :scraper do
  desc "Scrapes the apartment listings from 25% of the US cities listed craigslist"
  task scrape: :environment do
  	require 'open-uri'
	require 'nokogiri'
	require 'csv'

	# Rudy: how should I be thinking about this program from the perspective of class, object, method?

	usa_region_name = [
			# ['sfbay', 'CA', 'San Francisco'],
			# ['elko', 'Nevada', 'Elko'],
			# ['elmira', 'NY', 'Elmira corning'],
			# ['elpaso', 'TX', 'El Paso'],	
			# ['erie', 'PA', 'Erie'],
			['eugene', 'OR', 'Eugene']
			# ['evansville', 'IN', 'Evansville'],
			# ['fairbanks', 'AK', 'Fairbanks'],
			# ['fargo', 'ND', 'Fargo Moorhead'],
			# ['farmington', 'NM', 'Farmington'],
			# ['fayar', 'AR', 'Fayar'],
			# ['fayetteville', 'NC', 'Fayetteville'],
			# ['fingerlakes', 'NY', 'finger lakes'],
			# ['flagstaff', 'AZ', 'flagstaff'],
			# ['flint', 'Michigan', 'flint'],
			# ['shoals', 'Alabama', 'florence muscle shoals'],
			# ['florencesc', 'SC', 'florence'],
			# ['keys', 'FL', 'florida keys'],
			# ['fortcollins', 'CO' ,'fort collins'],
			# ['fortdodge', 'Iowa', 'fort dodge'],
			# ['fortsmith', 'AR', 'fort smith'],
			# ['fortwayne', 'Indiana', 'fort wayne'],
			# ['frederick', 'MD', 'frederick'],
			# ['fredericksburg', 'VA', 'fredericksburg'],
			# ['fresno', 'CA', 'fresno'],
			# ['fortmyers', 'FL', 'fortmyers'],
			# ['gadsden', 'AL', 'gadsden'],
			# ['gainesville', 'FL', 'gainesville'],
			# ['galveston', 'TX', 'galveston'],
			# ['glensfalls', 'NY', 'glens falls'],
			# ['goldcountry', 'CA', 'gold country'],
			# ['grandforks', 'ND', 'grand forks'],
			# ['grandisland', 'Nebraska', 'grand island'],
			# ['grandrapids_scraped', 'MI', 'grand rapids_scraped'],
			# ['greatfalls', 'Montana', 'great falls'],
			# ['greenbay', 'WI', 'green bay'],
			# ['greensboro', 'NC', 'greensboro'],
			# ['greenville', 'SC', 'greenville'],
			# ['gulfport', 'MI', 'gulfport biloxi'],
			# ['norfolk', 'VA', 'hampton roads'],
			# ['hanford', 'WA', 'hanford'],
			# ['harrisburg', 'PA', 'harrisburg'],
			# ['harrisonburg', 'VA', 'harrisonburg'],
			# ['hartford', 'CT', 'hartford'],
			# ['hattiesburg', 'MS', 'hattiesburg'],
			# ['honolulu', 'HI', 'honolulu'],
			# ['cfl', 'FL', 'heartland'],
			# ['helena', 'MT', 'helena'],
			# ['hickory', 'NC', 'hickory'],
			# ['rockies', 'CO', 'rockies'],
			# ['hiltonhead', 'SC', 'hiltonhead'],
			# ['holland', 'MI', 'holland'],
			# ['houma', 'LA', 'houma'],
			# ['houston', 'TX', 'houston'],
			# ['hudsonvalley', 'NY', 'hudsonvalley'],
			# ['humboldt', 'CA', 'humboldt'],
			# ['huntington', 'WV', 'huntington ashland'],
			# ['huntsville', 'IL', 'huntsville decatur'],
			# ['imperial', 'CA',  'imperial county'],
			# ['indianapolis', 'Indiana', 'indianapolis'],
			# ['inlandempire', 'CA', 'riverside san bernardino'],
			# ['iowacity', 'IA'], 'iowa city,
			# ['ithaca', 'NY', 'ithaca'],
			# ['jxn', 'MI', 'jackson'],
			# ['jackson', 'MS', 'jackson'],
			# ['jacksontn', 'TN', 'jackson'],
			# ['jacksonville', 'FL', 'jacksonville'],
			# ['onslow', 'NC', 'jacksonville'],
			# ['janesville', 'WI', 'janesville'],
			# ['jerseyshore', 'NJ', 'jersey shore'],
			# ['jonesboro', 'AK', 'jonesboro'],
			# ['joplin', 'MO', 'joplin'],
			# ['kalamazoo', 'Michigan', 'kalamazoo'],
			# ['kalispell', 'MT', 'kalispell'],
			# ['kansascity', 'MO', 'kansas city'],
			# ['kenai', 'AK', 'kenai'],
			# ['kpr', 'WA', 'kennewick pasco richland'],
			# ['racine', 'WI', 'kenosha racine'],
			# ['killeen', 'TX', 'temple fort hood'],
			# ['kirksville', 'MO', 'kirksville'],
			# ['klamath', 'OR', 'klamath'],
			# ['knoxville', 'TN', 'knoxville'],
			# ['kokomo', 'IN', 'kokomo'],
			# ['lacrosse', 'WI', 'lacrosse'],
			# ['lafayette', 'LA', 'lafayette'],
			# ['tippecanoe', 'IN', 'lafayette west lafayette'],
			# ['lakecharles', 'LA', 'lake charles'],
			# ['lakeland', 'FL', 'lakeland'],
			# ['loz', 'lake of the ozarks'],
			# ['lancaster', 'PA', 'lancaster'],
			# ['lansing', 'MI', 'lansing'],
			# ['laredo', 'TX', 'laredo'],
			# ['lasalle', 'IL', 'lasalle'],
			# ['lascruces', 'NM', las cruces],
			# ['lasvegas', 'NV', 'las vegas'],
			# ['lawrence', 'MA', 'lawrence'],
			# ['lawton', 'OK', 'lawton'],
			# ['allentown', 'PA', 'lehigh valley'],
			# ['mobile', 'AL', 'mobile'],
			# ['montgomery', 'AL', 'montgomery'],
			# ['tuscaloosa', 'AL', 'tuscaloosa'],
			# ['mattoon', 'AL', 'mattoon'], 
			# ['peoria', 'IL', 'peoria'],
			# ['rockford', 'AL', 'rockford'],
			# ['carbondale', 'AL', 'carbondale'],
			# ['springfieldil', 'AL', 'springfield'], 
			# ['quincy', 'AL', 'quincy'],
			# ['missoula', 'MT', 'missoula'], 
			# ['providence', 'RI', 'providence'], 
			# ['myrtlebeach', 'SC', 'myrtle beach'], 
			# ['juneau', 'AK', 'juneau'],
			# ['northplatte', 'NE', 'north platte'],
			# ['omaha', 'NE', 'omaha'],
			# ['scottsbluff', 'NE', 'scotts bluff'], 
			# ['nesd', 'SD', 'Sioux Falls']
		]


#write a function here


	usa_region_name.each do |region|
		page =  Nokogiri::HTML(open("http://"+ region[0] + ".craigslist.org/search/apa"))
		
		# sleep 3
		
		# this block scrapes craiglist and pushes the address field into
		# addresses_scraped.  If the individual address begins with a number
		# 0-9 then it is pushed into address_list_formatted and a region name is 
		# pushed into city_list_formatted, if not then address_scraped is pushed 
		# into city_list_formatted and an empty string is pushed into address_list_formatted. 

		address_list_formatted = []
		city_list_formatted = []

		addresses_scraped = page.css('div.content span.pnr small')
		
		addresses_scraped.each do |address|	
			temp = address.text.gsub(/[(),]/, "").strip #regex: delete parenthesis and commas
			if (/[0-9]/ =~ res[0]) != nil #regex: if res[0] IS a number 0-9
				address_list_formatted << temp
				city_list_formatted << region[2]
			else
				address_list_formatted << " "
				city_list_formatted << temp
	 		end
	 	end 

#reformate the following block and add a comments to explain what it is doing like in the block above

	 	# populating the br/ sq ft arr
		bedroom_list_formatted = []
		sqft_list_formatted = []
		temp = ""
		housing_info_scraped = page.css('span.txt span.housing')
		housing_info_scraped.each_with_index do |housing, idx|
			temp = housing.text.gsub(/\/\s+/, "").split(/\s+-\s+/)
			if (/br/ =~ temp[0]) != nil
				bedroom_list_formatted << temp[0].gsub(/br/, "").strip
			else
				bedroom_list_formatted << " "
			end

			if (/[0-9]/ =~ temp[1]) != nil
				sqft_list_formatted << temp[1].gsub(/ft2/, "").strip
			else
				sqft_list_formatted << " "
			end
		end 

		date_list_formatted = []
		dates_scraped = page.css('span.txt .pl time')
		dates_scraped.each do |date|
			date_list_formatted << date.text.strip 
		end

		id_list_formatted = []
		ids_scraped = page.css('div.content p.row')
		ids_scraped.each do |id|
			id_list_formatted << id['data-pid'].strip
		end

		title_list_formatted = []
		titles_scraped = page.css('span.txt .pl a')
		titles_scraped.each do |title|
			title_list_formatted << title.text.gsub(/[,]/, "").strip
		end 

		prices_scraped = page.css('span.txt span.price')
		price_list_formatted = prices_scraped.map do |price|
			price.text.gsub(/[$]/, "") 
		end 

		#populating states array
		state_array = []
		date_list_formatted.length.times do 
			state_array << region[1]
		end

		#populating cl_regions array
		cl_region_list = []
		date_list_formatted.length.times do 
			cl_region_list << region[2]
		end

		
		res = []
		date_list_formatted.length.times do |i|
			
			#create a new listing
			listing = {}
			listing[:address] = address_list_formatted[i] if address_list_formatted[i].present? 
			listing[:date] = date_list_formatted[i] if date_list_formatted[i].present?
			listing[:listing_id] = id_list_formatted[i] if id_list_formatted[i].present?
			listing[:listing_title] = title_list_formatted[i] if title_list_formatted.present?
			listing[:price] = price_list_formatted[i] if price_list_formatted[i].present?
			listing[:bedrooms] = bedroom_list_formatted[i] if bedroom_list_formatted[i].present?
			listing[:square_ft] = sqft_list_formatted[i] if sqft_list_formatted[i].present?
			listing[:city] = city_list_formatted[i] if city_list_formatted[i].present?
			listing[:state] = state_array[i] if state_array[i].present?
			listing[:cl_region] = cl_region_list[i] if cl_region_list[i].present?
			res << listing
		end		
		#save one listing
		Listing.create(res)
	 end
  end




  desc "Fetch Craigslist 26-50% all USA posts from Scraper"
  task scrape: :environment do
  end


  desc "Fetch Craigslist 51-75% all USA posts from Scraper"
  task scrape: :environment do
  end

  desc "Fetch Craigslist 76-100% all USA posts from Scraper"
  task scrape: :environment do
  end

end
