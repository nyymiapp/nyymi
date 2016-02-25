class Application < ActiveRecord::Base
	belongs_to :open_job
	belongs_to :user
	has_many :experiences 
	validates :user_id, numericality: { greater_than_or_equal_to: 1, only_integer: true }
	validates :open_job_id, numericality: { greater_than_or_equal_to: 1, only_integer: true }

	scope :not_abandoned, -> { where abandoned:[nil,false]  }
end
