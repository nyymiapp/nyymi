require 'rails_helper'

RSpec.describe "conversations/index", type: :view do
  before(:each) do
    assign(:conversations, [
      Conversation.create!(
        :user_id => 1,
        :company_id => 2
      ),
      Conversation.create!(
        :user_id => 1,
        :company_id => 2
      )
    ])
  end

  it "renders a list of conversations" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
