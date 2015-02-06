class BattlesController < ApplicationController
  respond_to :json

  # def login_token
  #   if @user
  #     cookies[:dish_it_token] = { value: params[:token], expires: 14.days.from_now }
  #     render json: @user, include: { county: { only: :name } } ,except: [:password_digest], status: :ok
  #   else
  #     cookies.delete(:dish_it_token)
  #     render plain: 'invalid-token', status: :bad_request
  #   end      
  # end

  def show
    date = Date.parse(params[:date])
    if date.is_a?(Date)
      date = date.end_of_month
      @battle = Battle.find_by(year_month: date)
      if @battle
        render json: @battle, status: :ok
      else
        render plain: "Battle for #{date.strftime(%B, %Y)} not found", status: :bad_request
      end
    else
      render plain: 'Invalid date parameter', status: :bad_request
    end
  end

end
