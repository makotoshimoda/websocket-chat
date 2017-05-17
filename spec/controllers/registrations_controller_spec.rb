require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

	describe "GET new" do
    it "assigns a new user as @user" do
      get :new, {}
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST create" do
    it "creates a new User" do
      expect {
        post :create, params:{ user: { name: "New User"} }
        }.to change(User, :count).by(1)
    end

    it "assigns a newly created user as @user" do
      post :create, params:{ user: { name: "New User"} }
      expect(assigns(:user)).to be_a(User)
      expect(assigns(:user)).to be_persisted
    end

    it "redirects to rooms list" do
      post :create, params:{ user: { name: "New User"} }
      expect(response).to redirect_to(rooms_path)
    end
  end

end