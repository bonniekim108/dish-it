class UsersController < ApplicationController
  respond_to :json

  def login_token
puts params[:token]
    @user = User.find_by(:token => params[:token]) 
    if @user
      cookies[:dish_it_token] = { value: params[:token], expires: 14.days.from_now }
      render json: @user, include: { county: { only: :name } } ,except: [:password_digest], status: :ok
    else
      cookies.delete(:dish_it_token)
      render plain: 'invalid-token', status: :bad_request
    end      
  end

  def login_email
    @user = User.find_by(email: params[:login][:email])
    if @user && @user.authenticate(params[:login][:password])
      set_token(@user)
      render json: @user, include: { county: { only: :name } } ,except: [:password_digest], status: :ok
    else
      render plain: 'invalid-credentials', status: :bad_request
    end      
  end

  def logout
    user = current_user
    if user
      user.token = nil
      user.save
      cookies.delete(:dish_it_token)
    end
    render json: '{}', status: :ok
  end

  def signup
    @user = User.new(params.require(:signup).permit(:email, :name, :password, :password_confirmation))
    @user.county = County.find(params[:signup][:county])
    if @user.valid?
      set_token(@user)
      render json: @user, include: { county: { only: :name } } ,except: [:password_digest], status: :created
    else
      render plain: @user.errors.full_messages.to_sentence, status: :bad_request
    end
  end

  private

  def set_token(user)
    token = SecureRandom.base64
    user.token = token
    user.save
    cookies[:dish_it_token] = { value: token, expires: 14.days.from_now }
  end

end
