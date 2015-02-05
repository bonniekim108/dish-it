class UsersController < ApplicationController
  respond_to :json

  def get_user

    render json: '{"data": "test data from get_user"}'

  end

end
