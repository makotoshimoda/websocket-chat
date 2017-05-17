require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  describe "POST create" do
    it "creates a new message" do
    	@user = FactoryGirl.create(:user)
	    @room = FactoryGirl.create(:room)
	    session[:user_id] = @user.id
      expect {
          post :create, params:{ message: { content: "message test", room_id: @room.id}}
          }.to change(Message, :count).by(1)
    end
  end

end