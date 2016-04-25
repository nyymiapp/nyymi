require 'rails_helper'

RSpec.describe User, type: :model do
 
 before :each do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.start
 end

 it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
    DatabaseCleaner.clean
 end
  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
    DatabaseCleaner.clean
  end

 it "is not saved with a bad password" do
    user = User.create username:"Pekka", password:"huo"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
    DatabaseCleaner.clean
 end

 it "is saved with a proper password" do
    user = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
    DatabaseCleaner.clean
  end

  it "is not saved if username is already in use" do
    user = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)

    user2 = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"
    expect(user2.valid?).to be(false)
    expect(User.count).to eq(1)
    DatabaseCleaner.clean
  end
end
