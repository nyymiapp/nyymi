require 'rails_helper'

describe "Applications page" do

	before :all do
    	self.use_transactional_fixtures = false
  	end

	before :each do
    	DatabaseCleaner.strategy = :truncation
    	DatabaseCleaner.start
    end
    
	describe "When company and open job is created" do 
	  it "user can make an application", js:true do

      	user = User.create username:"Arto", password:"Foobar1", password_confirmation:"Foobar1"


      	company = Company.create name:"UMT Software"
      	@user2 = User.create username:"Pekka3", password:"Foobar1", password_confirmation:"Foobar1", id:2, email:"toivanenpihla@gmail.com"
      	company.users << @user2
      	company.save

      	date = DateTime.now + 2.months
      	job = OpenJob.create name:"developer", company_id:"1", expires:date


      	sign_in(username:"Arto", password:"Foobar1")

      	visit open_jobs_path
      	click_link "developer"
      	find('#create_application_button').click

      	find("#create_experience_button").click
      	select "Työ", :from => "experience_place"
      	fill_in('experience[strictplace]', with:'paikka')
      	fill_in('experience[des]', with:'kuvaus')
      	find("#save_experience").click
      	expect(page).to have_content "tallennettu"

      	click_button "Lähetä hakemus!"
      	expect(page).to have_content "Hakemus luotu!"
    end

  		after :each do
    		DatabaseCleaner.clean
  		end

  		after :all do
    		self.use_transactional_fixtures = true
  		end

		/it "user can make application with experiences", js:true do 
			user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1", id:1
			sign_in_and_go_to_create_application

			find("#create_experience_button").click
			select "Työ", :from => "experience_place"
			fill_in('experience[strictplace]', with:'paikka')
			fill_in('experience[des]', with:'kuvaus')
			find("#save_experience").click
			expect(page).to have_content "tallennettu"

			click_button "Lähetä hakemus!"
			user.destroy
			@user2.destroy
			e = Experience.create description:"kuvaus"
			e.destroy
		end/


		it "admin of company can see applications and toggle abandoned", js:true do 
			user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1", id:1
			user2 = User.create username:"Pekka2", password:"Foobar1", password_confirmation:"Foobar1", id:2
			company = Company.create name:"UMT Software"
			company.users << user
			company.save
			date = DateTime.now + 2.months
			job = OpenJob.create name:"developer", company_id:"1", expires:date
			application = Application.create open_job_id:job.id, user_id:2

			sign_in(username:"Pekka", password:"Foobar1")
			visit administration_open_job_path(job.id)
			expect(page).to have_content "Pekka2"
			find("#hidden-partial-1").click
			click_link "hylkää hakemus"

			click_link "Näytä myös hylätyt hakemukset"
			sleep 5.seconds
			
			user.destroy
			user2.destroy
			company.destroy

		end
	end
end

def sign_in_and_go_to_create_application
	company = Company.create name:"UMT Software"
	@user2 = User.create username:"Pekka2", password:"Foobar1", password_confirmation:"Foobar1", id:2, email:"toivanenpihla@gmail.com"
	company.users << @user2
	company.save
	date = DateTime.now + 2.months
	job = OpenJob.create name:"developer", company_id:"1", expires:date
	sign_in(username:"Pekka", password:"Foobar1")
	visit open_jobs_path
	click_link "developer"
	find('#create_application_button').click

end
