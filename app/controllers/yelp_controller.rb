class YelpController < ApplicationController
  respond_to :json

  def search
    response = Yelp.client.search(params[:county], {term: params[:term]})
    render json: response
  end

end
