require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

	describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
  	describe "with valid params" do
	    it "redirects to rooms list" do
	    	user = FactoryGirl.create(:user)
	      post :create, params:{ user: { name: user.name} }
	      expect(response).to redirect_to(rooms_path)
	    end
	  end

	  describe "with invalid params" do
	    it "re-renders the 'new' template" do
	      post :create, params:{ user: { name: ''} }
	      expect(response).to redirect_to login_path
	    end
	  end
  end

end