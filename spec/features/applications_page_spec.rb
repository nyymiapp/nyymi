require 'rails_helper'

describe "Applications page" do
	let!(:user) { FactoryGirl.create :user }
  	let!(:user2) { FactoryGirl.create :user2 }

	describe "When company and open job is created" do 
		/it "user can make an application" do
			o = OpenJob.new id:1
			sign_in_create_company_create_open_job
			sign_in(username:"Pekka2", password:"Foobar1")
			visit new_application_path
			fill_in('application[open_job_id]', with:'1')
			fill_in('application[user_id]', with:'1')
			click_button "Create Application"
			expect(page).to have_content "Application was successfully created."
		end/
	end
end

def sign_in_create_company_create_open_job
	sign_in(username:"Pekka", password:"Foobar1")
  	visit new_company_path
  	fill_in('company[name]', with:'nimi')
  	fill_in('company[location]', with:'paikkakunta')
  	fill_in('company[website]', with:'nettisivut')
  	fill_in('company[description]', with:'kuvaus')

    click_button "Create Company"

    click_link "Admin page"
	fill_in('open_job[name]', with:'developer')
  	fill_in('open_job[description]', with:'rails-kehittäjä')
  	click_button "Create Open job"

  	expect(page).to have_content "Open job was successfully created."
  	expect(OpenJob.count).to eq(1)
  	click_link "Kirjaudu ulos"

end