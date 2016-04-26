require 'rails_helper'

describe "Companies page" do

  before :each do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.start
  end

  self.use_transactional_fixtures = false

  it "should not have any before been created" do
    self.use_transactional_fixtures = false
    visit companies_path
    expect(page).to have_no_content "Luo uusi yritys"
    DatabaseCleaner.clean
  end

  describe "User not logged in " do
  	it "couldn't go to new company path" do 
      self.use_transactional_fixtures = false
  		visit new_company_path
  		expect(page).to have_content "You are not authorized to access this page."
      DatabaseCleaner.clean
  	end

  	it "couldn't go to edit company path" do 
      self.use_transactional_fixtures = false
  		Company.create name:"Yritys"
  		visit edit_company_path(Company.first)
  		expect(page).to have_content "You are not authorized to access this page."
      DatabaseCleaner.clean
  	end

  	it "couldn't go to company administration path" do 
      self.use_transactional_fixtures = false
  		Company.create name:"Yritys"
  		visit administration_company_path(Company.first)
  		expect(page).to have_content "You are not authorized to access this page."
      DatabaseCleaner.clean
  	end

  	it "can go to about path" do 
      self.use_transactional_fixtures = false
  		visit about_path
  		expect(page).to have_content "Nyymistä"
  	end
  end

  describe "User logged in" do 
    DatabaseCleaner.clean
  	let!(:user) { FactoryGirl.create :user }
  	let!(:user2) { FactoryGirl.create :user2 }

  	it "doesn't see admin page button when not admin" do 
      self.use_transactional_fixtures = false
  		Company.create name:"yritys"
  		sign_in(username:"Pekka", password:"Foobar1")
  		visit company_path(Company.first)
  		expect(page).to have_no_content "Admin page"
      DatabaseCleaner.clean
  	end

  	it "couldn't go to company administration path if not admin" do 
      self.use_transactional_fixtures = false
  		Company.create name:"Yritys"
  		sign_in(username:"Pekka", password:"Foobar1")
  		visit administration_company_path(Company.first)
  		expect(page).to have_content "You are not authorized to access this page."
       DatabaseCleaner.clean
  	end

  	it "can go to about path" do 
      self.use_transactional_fixtures = false
  		sign_in(username:"Pekka", password:"Foobar1")
  		visit about_path
  		expect(page).to have_content "Nyymistä"
      DatabaseCleaner.clean
  	end

  	it "can create a company from index page" do 
      self.use_transactional_fixtures = false
  		sign_in(username:"Pekka", password:"Foobar1")
  		visit companies_path
  		expect(page).to have_content "Luo uusi yritys"
      DatabaseCleaner.clean
  	end

  	it "becomes administrator when creates a company" do 
      self.use_transactional_fixtures = false
  		sign_in_and_create_company

  		click_link "Ylläpito"
    	expect(page).to have_content "Ylläpitäjät"
    	expect(page).to have_content "Pekka"
       DatabaseCleaner.clean
  	end

  	it "can destroy company when administrator" do 
      self.use_transactional_fixtures = false
  		sign_in_and_create_company
  		click_link "Ylläpito"
  		click_link "Poista yritys"
    	expect(Company.count).to eq(0)
       DatabaseCleaner.clean
  	end

  	it "can update company information when administrator" do 
      self.use_transactional_fixtures = false
  		sign_in_and_create_company
  		  
  		click_link "Ylläpito"
  		click_link "Muokkaa perustietoja"
  		fill_in('company[description]', with:'uusikuvaus')
  		click_button "Update Company"
  		expect(page).to have_content "Päivitetty"
  		visit company_path(Company.first)
  		expect(page).to have_content "uusikuvaus"
       DatabaseCleaner.clean
  	end

    it "can add admin when administrator", js:true do 
      self.use_transactional_fixtures = false
      user2 = User.create username:"Pekka2", password:"Foobar1", password_confirmation:"Foobar1"
      sign_in_and_create_company
        
      click_link "Ylläpito"
      find('#add_admin_button').click
      fill_in('admin[username]', with:'Pekka2')
      click_button "Lisää"
      expect(page).to have_content "Ylläpitäjä lisätty"
      user2.destroy
      DatabaseCleaner.clean
    end

  	it "couldn't go to edit company path when not administrator" do 
      self.use_transactional_fixtures = false
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
      DatabaseCleaner.clean
  	end

      after :each do
        DatabaseCleaner.clean
      end

      after :all do
        self.use_transactional_fixtures = true
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

    	expect(page).to have_content "Ylläpito"
end