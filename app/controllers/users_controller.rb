class UsersController < ApplicationController
  respond_to :json

  def login_token
    @user = User.find_by(token: params[:token])
    if @user
      session[:expires_at] = Date.today + 14.days
      render json: @user, status: :ok
    else
      session[:dish_it_token] = nil
      render plain: 'invalid-token', status: :bad_request
    end      
  end

  def login_email
    @user = User.find_by(email: params[:login][:email])
    if @user && @user.authenticate(params[:login][:password])
      set_token(@user)
      render json: @user, status: :ok
    else
      render plain: 'invalid-credentials', status: :bad_request
    end      
  end

  def signup
    @user = User.new(params.require(:signup).permit(:email, :name, :password, :password_confirmation))
    @user.county = County.find(params[:signup][:county])
    if @user.valid?
      set_token(@user)
      render json: @user, status: :created
    else
      render plain: @user.errors.full_messages.to_sentence, status: :bad_request
    end
  end

  private

  def set_token(user)
    token = SecureRandom.base64
    user.token = token
    user.save
    session[:dish_it_token] = token
    session[:expires_at] = Date.today + 14.days
  end

end
