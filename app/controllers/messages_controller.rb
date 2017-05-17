class MessagesController < ApplicationController
  
  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      ActionCable.server.broadcast 'messages',
        message: @message.content,
        user: @message.user.name
      head :ok
    else
      redirect_to rooms_path
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
       params.require(:message).permit(:content, :room_id)
    end
end
