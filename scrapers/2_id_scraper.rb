require 'open-uri'
require 'nokogiri'
require 'csv'
require 'pry'


city_name = 'sfbay'
url = 'https://sfbay.craigslist.org/search/apa'
page = Nokogiri::HTML(open(url))

ids = page.css('div.content p.row')
@id_array = ids.map do |id|	
	id['data-pid'] 
end



