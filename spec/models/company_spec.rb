require 'rails_helper'

ApplicationsController
CompaniesController
OpenJobsController
SessionsController
UsersController
ApplicationsController
Company
OpenJob
User
Application

RSpec.describe Company, type: :model do
	it "has the name set correctly" do
    company = Company.new name:"UMT Software"

    company.name.should == "UMT Software"
  end

  it "is not saved without valid name" do
    company = Company.create name:""

    expect(company).not_to be_valid
    expect(Company.count).to eq(0)
  end

  describe "with name" do
  	let(:user){FactoryGirl.create(:user) }
    let(:company){ Company.create name:"UMT Software"}

    it "is saved" do
      expect(company).to be_valid
      expect(Company.count).to eq(1)
    end

    it "has correct first admin" do
    	user.companies << company
    	expect(company.users.count).to eq(1)
    	expect(company.users.first.username).to eq("Pekka")
    end
  end

end
