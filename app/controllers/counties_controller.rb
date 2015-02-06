class CountiesController < ApplicationController
  respond_to :json

  def index
    @counties = County.all
    render json: @counties
  end

end
