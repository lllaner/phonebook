class Api::ApplicationController < ApplicationController
  def authenticate_token
    decoded_token = JWT.decode params[:token], nil, false
    @user = User.find(decoded_token[0]['user_id'])
  rescue JWT::DecodeError => e
    render json: {error: e.message}
  end
end
