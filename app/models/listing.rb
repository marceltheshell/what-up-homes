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
end
