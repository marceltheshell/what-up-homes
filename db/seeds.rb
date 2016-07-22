f1 = "/Users/marceldegas/dev/what-up-homes/aaa_craigslist_listings_wuh.csv"

def inputListings(file)
	temp = nil
	res = []
	f = File.open(file)
	f_read = f.read
	f_read.each_line do |line|
		temp = line.split(",")
		listing = {}
		listing[:address] = temp[0]
		listing[:date] = temp[1]
		listing[:listing_id] = temp[2]
		listing[:listing_title] = temp[3]
		listing[:price] = temp[4]
		listing[:bedrooms] = temp[5]
		listing[:square_ft] = temp[6]
		listing[:city] = temp[7]
		listing[:state] = temp[8]
		res << listing 
	end
	Listing.create(res)
end

# clears db
# Listing.destroy_all

# refresh with new data
inputListings(f1)


	




 


