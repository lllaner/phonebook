class Api::V1::TelephoneBooksController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if @user
      render json: @user.telephone_books
    else
      render json: {error: 'Invalid token'}
    end
  end

  def show

  end

  private

  def token_params
    params.permit(:token)
  end
end
