class Api::V1::BasicController < ApplicationController
  before_action :authenticate_token

  def authenticate_token
    decoded_token = JWT.decode params[:token], nil, false
    @user = User.find(decoded_token[0]['user_id'])
  rescue JWT::DecodeError => e
    puts e
  end
end
