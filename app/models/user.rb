class User < ActiveRecord::Base
	has_secure_password
	has_and_belongs_to_many :companies
	has_many :applications

	PASSWORD_FORMAT = /\A
  	(?=.*\d)           # Must contain a digit
  	(?=.*[A-Z])        # Must contain an upper case character
	/x

    validates :password, length:{ minimum: 4 }, format: {with: PASSWORD_FORMAT}

    validates :username, length: { minimum: 1 }

end
