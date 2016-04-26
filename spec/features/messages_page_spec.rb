require 'rails_helper'
require 'spec_helper'

describe "Messages page" do
	before :each do
    	DatabaseCleaner.strategy = :truncation
    	DatabaseCleaner.start
    end
    
	self.use_transactional_fixtures = false

	it "user can create a message", js:true do 
		create_users_and_company
		sign_in(username:"Pekka", password:"Foobar1")
		visit company_path(Company.first)
		find("#send_message_button").click
		fill_in('message[content]', with:"SIsältööö")
		click_button "Lähetä"
		wait_for_websocket
		expect(page).to have_content "lähetetty"
		@user.destroy
		@company.destroy
		DatabaseCleaner.clean
	end

	it "user can see message", js:true do 
		create_users_and_company
		create_conversation_and_message
		sign_in(username:"Pekka", password:"Foobar1")
		click_link "Viestit"
		find("#hidden-partial-1").click
		expect(page).to have_content "juuhh"
		@user.destroy
		@company.destroy
		DatabaseCleaner.clean
	end

	after :each do
    	DatabaseCleaner.clean
  	end

  	after :all do
    	self.use_transactional_fixtures = true
  	end
end

def create_conversation_and_message
	@conversation = Conversation.create company:@company, user:@user, id:1
	@message = Message.create company: @company, user:@user, content: "juuhh", sender_id:2
	@conversation.messages << @message
	@conversation.save
end

def wait_for_websocket
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until message_sended?
    end
end

def message_sended?
    Company.first.conversations.length > 0
end