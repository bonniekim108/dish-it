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
    begin
      date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    rescue
      render plain: 'Invalid year and/or month parameters', status: :bad_request
    else
      date = date.end_of_month
      @battle = Battle.find_by(year_month: date)
      if @battle
        # render json: @battle, include: { dish: { only: [ :cuisine, :name ] }, trash_talks: { include: {user: { only: :name } } }, restaurants: { include: {votes: { include: { user: { only: :name } }, only: [ :created_at, :comment, :user ] } } } }, status: :ok
        render json: @battle, include: {
          dish: { only: [ :cuisine, :name ] },
          trash_talks: { include: {user: { only: :name } }, only: [ :created_at, :user, :trash ] },
          restaurants: { include: {votes: { include: { user: { only: :name } }, only: [ :created_at, :comment, :user ] } } }
          },
          status: :ok
        # render json: @battle, include: {dish: {only: [:cuisine, :name]}, restaurants: { include: { votes: { include: { user: { only: :name } } }, trash_talks: { include: :user } } } }, status: :ok
      else
        render plain: "Battle for #{date.strftime('%B, %Y')} not found", status: :bad_request
      end
    end
  end

end
