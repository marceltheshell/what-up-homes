require 'open-uri'
require 'nokogiri'
require 'csv'


# load '2_id_scraper.rb'

p "about to run iteration"

# url = 'https://sfbay.craigslist.org/eby/apa/5278726808.html'
# page = Nokogiri::HTML(open(url))

@id_array = [
	'5253991969'
	# '5255678681',
	# '5269959486',
	# '5280807143',
	# '5280788281',
	# '5280801348',
	# '5256688394',
	# '5235497968',
	# '5250438207',
	# '5235477133',
	# '5260577544',
	# '5280779992',
	# '5280776927',
	# '5280759578',
	# '5280771571',
	# '5280766453',
	# '5280762729',
	# '5280761719',
	# '5249675315',
	# '5280743465'
]

@id_array.each do |listing_id|
	page = Nokogiri::HTML(open('http://' + 'sfbay' + '.cragislist.org/apa/' + listing_id + '.html'))


	latlons = page.css('section.body div#map')
	puts "this is the latlon: #{latlons}"
	latlon_array = latlons.map do |latlon|
		lattitude = latlon['data-latitude']
		longitude = latlon['data-longitude']
		[lattitude, longitude]
	end
end


p "finished iteratino"

p "result is #{latlon_array}"

exit

	# CSV.open("craigslist_listings.csv", "a") do |file|
	# 	file << ["lat", "lng"]
	# 	date_array.length.times do |i|
	# 		file << [date_array[i], id_array[i], title_array[i], price_array[i], housing_array[i],  housing_array[i],  city_array[i] ]
	# 	end
	# end