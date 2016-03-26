class Conversation < ActiveRecord::Base
	belongs_to :user 
	belongs_to :company
	has_many :messages

	def not_seen(user_id)
		i = 0
		self.messages.reverse_each do |m|
			if m.seen or m.sender_id == user_id
				break
			else
				i = i+1
			end
		end
		return i
	end
end
