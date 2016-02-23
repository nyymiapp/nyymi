require 'rails_helper'

RSpec.describe "experiences/new", type: :view do
  before(:each) do
    assign(:experience, Experience.new(
      :application_id => 1,
      :place => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new experience form" do
    render

    assert_select "form[action=?][method=?]", experiences_path, "post" do

      assert_select "input#experience_application_id[name=?]", "experience[application_id]"

      assert_select "input#experience_place[name=?]", "experience[place]"

      assert_select "input#experience_description[name=?]", "experience[description]"
    end
  end
end
