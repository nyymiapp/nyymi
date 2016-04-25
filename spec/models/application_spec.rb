require 'rails_helper'

RSpec.describe Application, type: :model do
  self.use_transactional_fixtures = false

  before :each do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.start
  end

  it "is not saved without user_id and open_job_id" do
    application = Application.create 

    expect(application).not_to be_valid
    expect(Application.count).to eq(0)
  end

  it "is not saved with string user id" do
    application = Application.create user_id:"huono", open_job_id:1

    expect(application).not_to be_valid
    expect(Application.count).to eq(0)
  end

  it "is not saved with negative open job id" do
    application = Application.create user_id:1, open_job_id:-1

    expect(application).not_to be_valid
    expect(Application.count).to eq(0)
  end

    it "is saved with correct user id and open job id" do
    application = Application.create user_id:1, open_job_id:1

    expect(application).to be_valid
    expect(Application.count).to eq(1)
  end
end
