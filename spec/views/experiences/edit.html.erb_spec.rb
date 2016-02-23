require 'rails_helper'

RSpec.describe "experiences/edit", type: :view do
  before(:each) do
    @experience = assign(:experience, Experience.create!(
      :application_id => 1,
      :place => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit experience form" do
    render

    assert_select "form[action=?][method=?]", experience_path(@experience), "post" do

      assert_select "input#experience_application_id[name=?]", "experience[application_id]"

      assert_select "input#experience_place[name=?]", "experience[place]"

      assert_select "input#experience_description[name=?]", "experience[description]"
    end
  end
end
