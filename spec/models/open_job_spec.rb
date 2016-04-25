require 'rails_helper'

RSpec.describe OpenJob, type: :model do
  before :each do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.start
  end

  it "is not saved without a name" do
    open_job = OpenJob.create 

    expect(open_job.valid?).to be(false)
    expect(OpenJob.count).to eq(0)
    DatabaseCleaner.clean
  end

  it "is not saved with expire date in the past" do
    date = DateTime.now - 2.months
    open_job = OpenJob.create name:"UMT Software", expires:date

    expect(open_job.valid?).to be(false)
    expect(OpenJob.count).to eq(0)
    DatabaseCleaner.clean
  end

  describe "with name" do
    let(:company){ Company.create name:"UMT Software"}
    let(:open_job){ OpenJob.create name:"Developer"}

    it "is saved" do
      expect(open_job).to be_valid
      expect(OpenJob.count).to eq(1)
      DatabaseCleaner.clean
    end

    it "has correct company" do
    	company.open_jobs << open_job
    	expect(company.open_jobs.count).to eq(1)
    	expect(open_job.company.name).to eq("UMT Software")
      DatabaseCleaner.clean
    end
  end
end
