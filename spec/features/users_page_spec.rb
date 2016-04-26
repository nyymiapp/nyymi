require 'rails_helper'

describe "Users page" do
	before :each do
    	DatabaseCleaner.strategy = :truncation
    	DatabaseCleaner.start
    end

	describe "User not logged in" do 
		it "should see rekisteröidy and kirjaudu sisään buttons" do 
			self.use_transactional_fixtures = false
			visit root_path
			expect(page).to have_content "Rekisteröidy"
			expect(page).to have_content "Kirjaudu sisään"
			DatabaseCleaner.clean
		end

		it "should not log in when credentials are wrong" do 
			self.use_transactional_fixtures = false
			visit root_path
			click_link "Kirjaudu sisään"
			fill_in('username', with:'käyttäjänimi')
			fill_in('password', with:'salasana')
			click_button "Kirjaudu sisään"
			expect(page).to have_content "Käyttäjänimi ja/tai salasana väärin"
			DatabaseCleaner.clean
		end

		it "should log in automaticly when registered" do 
			self.use_transactional_fixtures = false
			visit root_path
			click_link "Rekisteröidy"

			fill_in('user[username]', with:'käyttäjänimi')
  			fill_in('user[realname]', with:'oikea nimi')
  			fill_in('user[email]', with:'maili')
  			fill_in('user[phonenumber]', with:'111')
  			fill_in('user[password]', with:'Foobar1!')
  			fill_in('user[password_confirmation]', with:'Foobar1!')
      		click_button "Create User"
    		expect(User.count).to eq(1)
			expect(page).to have_content "Tervetuloa!"
			DatabaseCleaner.clean
		end

	end

	describe "User logged in" do 
		let!(:user) { FactoryGirl.create :user }
		it "should see kirjaudu ulos button" do 
			self.use_transactional_fixtures = false
			visit root_path
			sign_in(username:"Pekka", password:"Foobar1")
			expect(page).to have_content "Kirjaudu ulos"
			DatabaseCleaner.clean
		end

		it "can edit realname" do 
			self.use_transactional_fixtures = false
			visit root_path
			sign_in(username:"Pekka", password:"Foobar1")
			click_link "Muokkaa tietoja"
			fill_in('user[realname]', with:'feikki')
			fill_in('user[password]', with:'Foobar1')
			fill_in('user[password_confirmation]', with:'Foobar1')
			click_button "Update User"
			expect(page).to have_content "feikki"
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