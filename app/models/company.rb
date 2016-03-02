class Company < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :open_jobs,  dependent: :destroy
	validates :name, length: { minimum: 1 }
	has_many :conversations
end
