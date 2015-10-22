require 'csv'

list_of_cities = ["bakersfield", "chico", "fresno", "goldcountry", "hanford", "inlandempire", "lasvegas", "losangeles", "mendocino", "merced", "modesto", "mohave", "monterey", "orangecounty", "palmsprings", "redding", "reno", "sacramento", "sandiego", "slo", "santabarbara", "santamaria", "sfbay", "siskiyou", "stgeorge", "stockton", "susanville", "ventura", "visalia", "yubasutter"]
list_of_urls = []
list_of_cities.each do |city_name|
	list_of_urls << "http://"+ city_name + ".craigslist.org/search/apa"
end


CSV.open("city_urls.csv", "w") do |file|
	file << ["CL_URL"]
	list_of_cities.length.times do |i|
		file << [list_of_urls[i]]
	end
end



