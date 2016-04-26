require 'rails_helper'
require 'spec_helper'

describe "Open jobs page" do
	before :each do
    	DatabaseCleaner.strategy = :truncation
    	DatabaseCleaner.start
    end
    
	describe "When user is administrator" do 
		Capybara.javascript_driver = :selenium
		DatabaseCleaner.clean

		it "can create an open job and edit description", js:true do 
			self.use_transactional_fixtures = false
			user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1"
			sign_in_and_create_company
			create_open_job
			click_link "developer"
			expect(page).to have_content "developer ylläpito"
			click_link "Muokkaa"
			fill_in('open_job[description]', with:'php-kehittäjä')
			click_button "Update Open job"
			expect(page).to have_content "php-kehittäjä"
			user.destroy
			DatabaseCleaner.clean
		end

		it "can destroy open job", js:true do 
			self.use_transactional_fixtures = false
			user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1"
			sign_in_and_create_company

			find(:css, '#company_administration').click
			find('#create_open_job_button').click

			fill_in('open_job[name]', with:'developer')
  			fill_in('open_job[description]', with:'rails-kehittäjä')
  			click_button "Create Open job"
			visit administration_open_job_path(OpenJob.first)
    	    click_link "Poista avoin työpaikka"
			expect(page).to have_content "Open job was successfully destroyed."
			user.destroy
			DatabaseCleaner.clean
		end

		it "cannot create open job without name", js:true do 
			self.use_transactional_fixtures = false
			user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1"
			sign_in_and_create_company

			find(:css, '#company_administration').click
			find('#create_open_job_button').click

			fill_in('open_job[description]', with:'rails-kehittäjä')

  			click_button "Create Open job"
			expect(page).to have_content "Nimeä tai viimeistä hakupäivää ei asetettu tai se on menneisyydessä!"
			user.destroy
			DatabaseCleaner.clean
		end

		it "cannot create open job with expired last open day", js:true do 
			self.use_transactional_fixtures = false
			DatabaseCleaner.clean
			user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1"
			sign_in_and_create_company
			
			find(:css, '#company_administration').click
			find('#create_open_job_button').click

			fill_in('open_job[name]', with:'developer')
  			fill_in('open_job[description]', with:'rails-kehittäjä')
  			page.find('#open_job_expires').set("2014-01-01")
  			click_button "Create Open job"
			expect(page).to have_content "Nimeä tai viimeistä hakupäivää ei asetettu tai se on menneisyydessä!"
			user.destroy
			DatabaseCleaner.clean
		end

		it "can see applications of open job", js:true do 
			self.use_transactional_fixtures = false
			user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1"
			sign_in_and_create_company
			create_open_job	

			application = Application.create user_id: User.first.id, open_job_id: OpenJob.first.id, freetext: "olen pekka"
			visit administration_open_job_path(OpenJob.first)

			find('.hidden_partial_button').click

			expect(page).to have_content "Pekka"
			expect(page).to have_content "olen pekka"
			user.destroy
			application.destroy
			DatabaseCleaner.clean
		end
	end

	describe "When not logged in" do 
		it "should see an open job" do
			self.use_transactional_fixtures = false
			company = Company.create name:"Yritys"
			open_job = OpenJob.create name:"developer", company: company
			visit open_job_path(OpenJob.first)
			expect(page).to have_content "Kirjaudu sisään jotta voit hakea!"
			company.destroy
			open_job.destroy
			DatabaseCleaner.clean
		end
	end

		after :each do
    		DatabaseCleaner.clean
  		end

  		after :all do
    		self.use_transactional_fixtures = true
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
	find(:css, '#company_administration').click
	find('#create_open_job_button').click
	fill_in('open_job[name]', with:'developer')
  	fill_in('open_job[description]', with:'rails-kehittäjä')
  	click_button "Create Open job"
	expect(page).to have_content "Avoin "
end