class UsersController < ApplicationController
  respond_to :json

  def get_user
    ret = {data: params[:token].to_s}
    render json: ret

  end

end
