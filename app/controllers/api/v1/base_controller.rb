class Api::V1::BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :destroy_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  attr_accessor :current_user

  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      puts errors.full_messages if errors.respond_to? :full_messages
    end
    head status: status and return if errors.empty?

    render json: jsonapi_format(errors).to_json, status: status
  end

  def jsonapi_format(errors)
    return errors if errors.is_a? String
    errors_hash = {}
    errors.messages.each do |attribute, error|
      array_hash = []
      error.each do |e|
        array_hash << {attribute: attribute, message: e}
      end
      errors_hash.merge!({ attribute => array_hash })
    end

    return errors_hash
  end

  def authenticate_user!
    authenticate_or_request_with_http_basic("Base") do |name|
      user = User.find_by_name(name)
      if user
      	@current_user = user
	    else
	      return unauthenticated!
	    end
    end
  end

  def unauthenticated!
    render json: { error: 'Bad credentials' }, status: 401
  end
end