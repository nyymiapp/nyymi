require 'rails_helper'

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
    let(:company){ Company.create name:"UMT Software"}

    it "is saved" do
      expect(company).to be_valid
      expect(Company.count).to eq(1)
    end
  end

end
