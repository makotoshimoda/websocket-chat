class Api::V1::SessionsController < Api::V1::BaseController
	# skip_before_action :verify_authenticity_token
  def create
    user = User.find_by(name: create_params[:name])
    if user 
      self.current_user = user
      render(
        json: Api::V1::SessionSerializer.new(user, root: false).to_json,
        status: 201
      )
    else
      return api_error(status: 401)
    end
  end

  private
  def create_params
    params.require(:user).permit(:name)
  end
end