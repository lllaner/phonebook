class Api::V1::UsersController < Api::ApplicationController
  # REGISTER

  def create
    @user = User.create(user_params)
    if @user.valid?
      payload = { user_id: @user.id }
      token = JWT.encode payload, nil, 'none', { typ: 'JWT' }
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(email: params[:email])

    if @user&.valid_password?(params[:password])
      payload = { user_id: @user.id }
      token = JWT.encode payload, nil, 'none', { typ: 'JWT' }
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username or password' }
    end
  end

  private

  def user_params
    params.permit(:email, :password, :token)
  end

end
