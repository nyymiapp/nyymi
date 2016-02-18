class Application < ActiveRecord::Base
	belongs_to :open_job
	belongs_to :user
end
