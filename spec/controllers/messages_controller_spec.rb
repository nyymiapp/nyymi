require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
	let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
 	 }

	describe "POST #create" do
    context "with valid params" do
      it "creates a new Message" do
        expect {
          post :create, {:message=> valid_attributes}, valid_session
        }.to change(Message, :count).by(1)
      end
    end
	end
end
