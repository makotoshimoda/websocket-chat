require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

	def valid_attributes
    { name: "New Chat",
     	slug: "newchat" }
  end
  
	before (:each) do
    @user = FactoryGirl.create(:user)
    @room = FactoryGirl.create(:room)
    @message = FactoryGirl.create(:message)
    @message.user = @user
    @message.room = @room
    session[:user_id] = @user.id
  end

	describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
    	get :show, params: { slug: @room.slug }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "should find the right room" do
      get :show, params: { slug: @room.slug }
      expect(assigns(:room)).to eq(@room)
    end
  end

  describe "GET new" do
    it "assigns a new room as @room" do
      get :new, {}
      expect(assigns(:room)).to be_a_new(Room)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Room" do
        expect {
          post :create, params:{ room: valid_attributes}
        }.to change(Room, :count).by(1)
      end

      it "assigns a newly created room as @room" do
        post :create, params:{ room: valid_attributes}
        expect(assigns(:room)).to be_a(Room)
        expect(assigns(:room)).to be_persisted
      end

      it "redirects to the created room" do
        post :create, params:{ room: valid_attributes}
        expect(response).to redirect_to(Room.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved room as @room" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Room).to receive(:save).and_return(false)
        post :create, params:{ room: {name: 1, slug: 23}}
        expect(assigns(:room)).to be_a_new(Room)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Room).to receive(:save).and_return(false)
        post :create, params:{ room: {name: 1, slug: 23}}
        expect(response).to redirect_to new_room_path
      end
    end
  end

end
