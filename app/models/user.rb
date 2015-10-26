class User < ActiveRecord::Base
	has_secure_password

	has_many :listings

	validates :email, uniqueness: true
	validates :password, length: { in: 4..20 }

	def self.confirm(params)
		@user = User.find_by({email: params[:email]})
	    @user.try(:authenticate, params[:password])
	end
end
