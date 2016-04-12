class User < ActiveRecord::Base
	has_secure_password
	has_and_belongs_to_many :companies
	has_many :applications
	has_many :open_jobs, through: :companies
	has_many :conversations

	PASSWORD_FORMAT = /\A
  	(?=.*\d)           # Must contain a digit
  	(?=.*[A-Z])        # Must contain an upper case character
	/x

    validates :password, length:{ minimum: 4 }

    validates :username, uniqueness: true, length: { minimum: 1 }

    def not_seen
    	sum = 0
    	self.conversations.each do |c|
    		sum += c.not_seen(self.id)
    	end
    	self.companies.each do |c|
    		c.conversations.each do |co|
    			if co.user_id != self.id 
    				sum += co.not_seen(self.id)
    			end
    		end
    	end
    	return sum
    end

end
