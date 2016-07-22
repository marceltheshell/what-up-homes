require "open-uri"
require "nokogiri"

url = "https://en.wikipedia.org/wiki/List_of_current_NBA_team_rosters"
page = Nokogiri::HTML(open(url))

full_page = page.css('td[style="text-align:left;"]')

full_page.each do |player|
	puts player.text + '<br>'
end