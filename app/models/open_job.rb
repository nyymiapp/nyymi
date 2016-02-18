class OpenJob < ActiveRecord::Base
	belongs_to :company
	has_many :applications
end
