require 'rails_helper'

describe "Users page" do
	describe "User not logged in" do 
		it "should see rekisteröidy and kirjaudu sisään buttons" do 
			visit root_path
			expect(page).to have_content "Rekisteröidy"
			expect(page).to have_content "Kirjaudu sisään"
		end

		it "should log in automaticly when registered" do 
			visit root_path
			click_link "Rekisteröidy"

			fill_in('user[username]', with:'käyttäjänimi')
  			fill_in('user[realname]', with:'oikea nimi')
  			fill_in('user[email]', with:'maili')
  			fill_in('user[phonenumber]', with:'111')
  			fill_in('user[password]', with:'Foobar1!')
  			fill_in('user[password_confirmation]', with:'Foobar1!')

  			expect{
      		click_button "Create User"
    			}.to change{User.count}.from(0).to(1)
			expect(page).to have_content "Welcome! Now you can"
		end

	end

	describe "User logged in" do 
		let!(:user) { FactoryGirl.create :user }
		it "should see kirjaudu ulos button" do 
			visit root_path
			sign_in(username:"Pekka", password:"Foobar1")
			expect(page).to have_content "Kirjaudu ulos"
		end

		#it "can edit realname" do 
		#	visit root_path
		#	sign_in(username:"Pekka", password:"Foobar1")
		#	click_link "Muokkaa tietoja"
		#	fill_in('user[realname]', with:'feikki')
		#end
	end


end