class OpenJob < ActiveRecord::Base
	belongs_to :company
	has_many :applications
	validate :expires_cannot_be_in_the_past

	def expires_cannot_be_in_the_past
    	if expires.present? && expires < DateTime.now
      		errors.add(:expires, "can't be in the past")
    	end
  	end
end
