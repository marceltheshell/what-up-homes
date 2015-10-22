load '2_id_scraper.rb'

p "about to run iteration"

city_name = "sfbay"

@id_array.each do |listing_id|
	page = Nokogiri::HTML(open('http://' + city_name + '.cragislist.org/apa/' + listing_id + '.html'))
	p "hit listing #{listing_id}"
	latlons = page.css('section.body div#map')
	binding.pry
	latlon_array =  latlons.map do |latlon|
		lattitude = latlon['data-latitude']
		longitude = latlon['data-longitude']
		[lattitude, longitude]
	end
end

p "finished iteratino"

p "result is #{latlon_array}"

exit
