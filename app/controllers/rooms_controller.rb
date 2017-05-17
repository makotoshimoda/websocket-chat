class RoomsController < ApplicationController
  before_action :set_room, :search, only: [:show]
  before_action :search

  # GET /rooms
  # GET /rooms.json
  def index
    @search = Room.search(params[:q])
    @rooms = Room.all.paginate(page: params[:page], per_page: 5)
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find_by(slug: params[:slug])
    @message = Message.new
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    respond_to do |format|
      if @room.save
        format.html { redirect_to @room }
      else
        flash[:notice] = { error: ["The name #{@room.name} was already taken by another room"] }
        format.html { redirect_to new_room_path }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find_by(slug: params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name)
    end

    #Search and redirect to the Chat
    def search
      return unless params[:q]

      query = params[:q].to_unsafe_h[:name_or_id]
      room = Room.where('name like :query or id = :id', query: query, id: query.to_i).try(:first)
      if room.blank?
        flash[:notice] = { error: ['Room not found'] }
      else
        redirect_to room
      end
    end

end
