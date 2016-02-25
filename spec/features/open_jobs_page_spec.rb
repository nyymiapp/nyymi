require 'rails_helper'
require 'spec_helper'

describe "Open jobs page" do
	describe "When user is administrator" do 
		let!(:user) { FactoryGirl.create :user }
		Capybara.javascript_driver = :poltergeist

		it "can create an open job and edit description" do 
			sign_in_and_create_company
			create_open_job

			click_link "developer"
			expect(page).to have_content "developer ylläpito"
			click_link "Muokkaa"
			fill_in('open_job[description]', with:'php-kehittäjä')
			click_button "Update Open job"
			expect(page).to have_content "php-kehittäjä"
		end

		it "can destroy open job" do 
			sign_in_and_create_company
			click_link "Admin page"
			fill_in('open_job[name]', with:'developer')
  			fill_in('open_job[description]', with:'rails-kehittäjä')
  			click_button "Create Open job"
			visit administration_open_job_path(OpenJob.first)
			click_link "Poista"
			expect(page).to have_content "Open job was successfully destroyed."
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

		it "can see applications of open job" do 
			sign_in_and_create_company
			create_open_job
			application = Application.create user_id: User.first.id, open_job_id: OpenJob.first.id, freetext: "olen pekka"
			visit administration_open_job_path(OpenJob.first)
			#click_link OpenJob.first.id
			#expect(page).to have_content "Pekka"
			#expect(page).to have_content "olen pekka"
		end
	end

	describe "When not logged in" do 
		it "should see an open job" do
			company = Company.create name:"Yritys"
			open_job = OpenJob.create name:"developer", company: company
			visit open_job_path(OpenJob.first)
			expect(page).to have_content "Kirjaudu sisään jotta voit hakea!"
		end
	end

	describe "When logged in" do 
		let!(:user) { FactoryGirl.create :user }
		let!(:user2) { FactoryGirl.create :user2 }
		it "cannot go to administration page" do 
			sign_in_and_create_company
			create_open_job
			click_link "Kirjaudu ulos"
			sign_in(username:"Pekka2", password:"Foobar1")
			visit administration_open_job_path(OpenJob.first)
			expect(page).to have_content "You're not admin!"
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

def create_open_job
		click_link "Admin page"
		fill_in('open_job[name]', with:'developer')
  		fill_in('open_job[description]', with:'rails-kehittäjä')
  		click_button "Create Open job"
		expect(page).to have_content "Avoin työpaikka luotu."
end