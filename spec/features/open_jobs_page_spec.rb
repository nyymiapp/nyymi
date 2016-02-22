require 'rails_helper'

describe "Open jobs page" do
	describe "When user is administrator" do 
		let!(:user) { FactoryGirl.create :user }

		it "can create an open job" do 
			sign_in_and_create_company
			click_link "Admin page"
			fill_in('open_job[name]', with:'developer')
  			fill_in('open_job[description]', with:'rails-kehittäjä')
  			click_button "Create Open job"
			expect(page).to have_content "Open job was successfully created."
		end

		it "cannot create open job without name" do 
			sign_in_and_create_company
			click_link "Admin page"
  			fill_in('open_job[description]', with:'rails-kehittäjä')
  			click_button "Create Open job"
			expect(page).to have_content "Nimeä tai viimeistä hakupäivää ei asetettu tai se on menneisyydessä!"
		end

		it "cannot create open job with expired last open day" do 
			sign_in_and_create_company
			click_link "Admin page"
			fill_in('open_job[name]', with:'developer')
  			fill_in('open_job[description]', with:'rails-kehittäjä')
  			page.find('#open_job_expires').set("2014-01-01")
  			click_button "Create Open job"
			expect(page).to have_content "Nimeä tai viimeistä hakupäivää ei asetettu tai se on menneisyydessä!"
		end
	end
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