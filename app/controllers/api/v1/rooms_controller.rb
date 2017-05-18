class Api::V1::RoomsController < Api::V1::BaseController
	include ActiveHashRelation

  def show
    room = Room.find_by(slug: params[:slug])
    if room.present?
    	render(json: Api::V1::RoomSerializer.new(room).to_json)
    else
    	return api_error(status: 404, errors: 'Not found')
    end
  end

  def index
    rooms = Room.all

    render json: rooms, each_serializer: Api::V1::RoomSerializer
  end
end