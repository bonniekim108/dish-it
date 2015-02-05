class UsersController < ApplicationController
  respond_to :json

  def get_user
    ret = {data: params[:token].to_s}
    render json: ret


  end

  def signup
    @user = User.new(params.require(:user).permit(:email, :name, :password, :password_confirmation))
    @user.county = County.find(params[:user][:county])
    if @user.valid?
      @user.token = SecureRandom.base64
      @user.save
      render json: @user
    else

    end

  end

end
