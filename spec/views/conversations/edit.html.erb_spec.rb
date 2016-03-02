require 'rails_helper'

RSpec.describe "conversations/edit", type: :view do
  before(:each) do
    @conversation = assign(:conversation, Conversation.create!(
      :user_id => 1,
      :company_id => 1
    ))
  end

  it "renders the edit conversation form" do
    render

    assert_select "form[action=?][method=?]", conversation_path(@conversation), "post" do

      assert_select "input#conversation_user_id[name=?]", "conversation[user_id]"

      assert_select "input#conversation_company_id[name=?]", "conversation[company_id]"
    end
  end
end
