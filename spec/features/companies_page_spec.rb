require 'rails_helper'

describe "Companies page" do
  it "should not have any before been created" do
    visit companies_path
    expect(page).to have_no_content "Luo uusi yritys"
  end

  describe "User not logged in " do
  	it "couldn't go to new company path" do 
  		visit new_company_path
  		expect(page).to have_content "You are not authorized to access this page."
  	end

  	it "couldn't go to edit company path" do 
  		Company.create name:"Yritys"
  		visit edit_company_path(Company.first)
  		expect(page).to have_content "You are not authorized to access this page."
  	end

  	it "couldn't go to company administration path" do 
  		Company.create name:"Yritys"
  		visit administration_company_path(Company.first)
  		expect(page).to have_content "You are not authorized to access this page."
  	end

  	it "can go to about path" do 
  		visit about_path
  		expect(page).to have_content "Nyymistä"
  	end
  end

  describe "User logged in" do 
  	let!(:user) { FactoryGirl.create :user }
  	let!(:user2) { FactoryGirl.create :user2 }

  	it "doesn't see admin page button when not admin" do 
  		Company.create name:"yritys"
  		sign_in(username:"Pekka", password:"Foobar1")
  		visit company_path(Company.first)
  		expect(page).to have_no_content "Admin page"
  	end

  	it "couldn't go to company administration path if not admin" do 
  		Company.create name:"Yritys"
  		sign_in(username:"Pekka", password:"Foobar1")
  		visit administration_company_path(Company.first)
  		expect(page).to have_content "You are not authorized to access this page."
  	end

  	it "can go to about path" do 
  		sign_in(username:"Pekka", password:"Foobar1")
  		visit about_path
  		expect(page).to have_content "Nyymistä"
  	end

  	it "can create a company from index page" do 
  		sign_in(username:"Pekka", password:"Foobar1")
  		visit companies_path
  		expect(page).to have_content "Luo uusi yritys"
  	end

  	it "becomes administrator when creates a company" do 
  		sign_in_and_create_company

  		click_link "Admin page"
    	expect(page).to have_content "Ylläpitäjät"
    	expect(page).to have_content "Pekka"
  	end

  	it "can destroy company when administrator" do 
  		sign_in_and_create_company
  		click_link "Admin page"
  		click_link "Poista yritys"
    	expect(Company.count).to eq(0)
  	end

  	it "can update company information when administrator" do 
  		sign_in_and_create_company
  		  
  		click_link "Admin page"
  		click_link "Muokkaa perustietoja"
  		fill_in('company[description]', with:'uusikuvaus')
  		click_button "Update Company"
  		expect(page).to have_content "Company was successfully updated."
  		visit company_path(Company.first)
  		expect(page).to have_content "uusikuvaus"
  	end

  	it "couldn't go to edit company path when not administrator" do 
  		sign_in(username:"Pekka2", password:"Foobar1")
  		visit new_company_path

  		fill_in('company[name]', with:'nimi')
  		fill_in('company[location]', with:'paikkakunta')
  		fill_in('company[website]', with:'nettisivut')
  		fill_in('company[description]', with:'kuvaus')
      	
      	click_button "Create Company"
      	click_link "Kirjaudu ulos"

      	sign_in(username:"Pekka", password:"Foobar1")

      	expect(Company.count).to eq(1)

      	visit edit_company_path(Company.first)
  		expect(page).to have_content "You are not authorized to access this page."
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

  		expect{
      		click_button "Create Company"
    	}.to change{Company.count}.from(0).to(1)

    	expect(page).to have_content "Admin page"
end