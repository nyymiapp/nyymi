require 'rails_helper'

RSpec.describe "experiences/index", type: :view do
  before(:each) do
    assign(:experiences, [
      Experience.create!(
        :application_id => 1,
        :place => "Place",
        :description => "Description"
      ),
      Experience.create!(
        :application_id => 1,
        :place => "Place",
        :description => "Description"
      )
    ])
  end

  it "renders a list of experiences" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Place".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
