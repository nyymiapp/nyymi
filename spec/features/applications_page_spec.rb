require 'rails_helper'

describe "Applications page" do

	describe "When company and open job is created" do 
		it "user can make an application", js:true do
			user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1", id:1
			sign_in_and_create_application

			click_button "Lähetä hakemus!"
			expect(page).to have_content "Hakemus luotu!"

			user.destroy
			DatabaseCleaner.clean
		end

		it "user can make application with experiences", js:true do 
			user = User.create username:"Pekka", password:"Foobar1", password_confirmation:"Foobar1", id:1
			sign_in_and_create_application

			find("#create_experience_button").click
			select "Työ", :from => "experience_place"
			fill_in('experience[strictplace]', with:'paikka')
			fill_in('experience[des]', with:'kuvaus')
			find("#save_experience").click
			expect(page).to have_content "tallennettu"

			user.destroy
			e = Experience.create description:"kuvaus"
			e.destroy
			DatabaseCleaner.clean

		end


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
			
			user.destroy
			user2.destroy
			company.destroy
			DatabaseCleaner.clean

		end
	end
end

def sign_in_and_create_application
	#sign_in_create_company_create_open_job
			
	#click_link "Kirjaudu ulos"
	company = Company.create name:"UMT Software"
	date = DateTime.now + 2.months
	job = OpenJob.create name:"developer", company_id:"1", expires:date

	sign_in(username:"Pekka", password:"Foobar1")
			
	visit open_jobs_path

	click_link "developer"

	find('#create_application_button').click

end
