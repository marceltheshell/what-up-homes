class Listing < ActiveRecord::Base


	geocoded_by :full_address
	after_validation :geocode

	def full_address
	  [address, city, state].compact.join(', ')
	end



	

	# def create 
	# 	Address.create(location_params)
	# end

	# private
	# def location_params
	# 	params.require(:address).permit(:lattitude, :longitude)
	# end
end
