class Api::AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: [:login, :register]

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JWT.encode({ user_id: @user.id }, Rails.application.credentials.secret_key_base)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     email: @user.email, role: @user.role }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def register
    @user = User.new(user_params)
    if @user.save
      token = JWT.encode({ user_id: @user.id }, Rails.application.credentials.secret_key_base)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     email: @user.email, role: @user.role }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end