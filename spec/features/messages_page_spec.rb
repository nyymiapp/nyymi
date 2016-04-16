require 'rails_helper'
require 'spec_helper'

describe "Messages page" do
	it "user can create a message", js:true do 
		user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1", channel:"abc123"
		sign_in(username:"Pekka", password:"Foobar1")
		company = Company.create name:"UMT Software", id:1
		user2 = User.create username:"Pekka2", password:"Foobar1", password_confirmation:"Foobar1", channel:"def456"
		company.users << user2
		company.save
		visit company_path(Company.first)
		find("#send_message_button").click
		fill_in('message[content]', with:"SIsältööö")
		click_button "Lähetä"
		wait_for_websocket
		expect(page).to have_content "lähetetty"

		user.destroy
		company.destroy
		DatabaseCleaner.clean
	end
end

 def wait_for_websocket
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until message_sended?
    end
  end

  def message_sended?
    Company.first.conversations.length > 0
  end

def sign_in_and_create_company
	sign_in(username:"Pekka", password:"Foobar1")
  	visit new_company_path
  	fill_in('company[name]', with:'nimi')
  	fill_in('company[location]', with:'paikkakunta')
  	fill_in('company[website]', with:'nettisivut')
  	fill_in('company[description]', with:'kuvaus')

    click_button "Create Company"
end