class Listing < ActiveRecord::Base

	geocoded_by :full_address
	after_validation :geocode

	def full_address
	  [address, city, state].compact.join(', ')
	end

	def self.search(search)
		# if search
		# 	find(:all, :conditions) => ['name LIKE ?', "%#{search}%"])
		# else
		# 	find(:all)
		# end
	end

	def self.to_csv
		attributes = ["Address", "Date", "Listing_ID", "Listing_Title", "Price", "Bedrooms", "Square_Ft", "City", "State", "CL_region", "Zip_code"]
		
		CSV.generate(headers: true) do |csv|
			csv << attributes 

			all.each do |listing|
				listing.attributes.values_at(*attributes)
			end
		end
	end
end
