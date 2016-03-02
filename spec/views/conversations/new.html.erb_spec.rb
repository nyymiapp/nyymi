require 'rails_helper'

RSpec.describe "conversations/new", type: :view do
  before(:each) do
    assign(:conversation, Conversation.new(
      :user_id => 1,
      :company_id => 1
    ))
  end

  it "renders new conversation form" do
    render

    assert_select "form[action=?][method=?]", conversations_path, "post" do

      assert_select "input#conversation_user_id[name=?]", "conversation[user_id]"

      assert_select "input#conversation_company_id[name=?]", "conversation[company_id]"
    end
  end
end
