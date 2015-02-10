class BattlesController < ApplicationController
  protect_from_forgery with: :null_session
  
  respond_to :json

  def show
    begin
      date = Date.new(params[:year].to_i, params[:month].to_i, 1)
    rescue
      render plain: 'Invalid year and/or month parameters', status: :bad_request
    else
      date = date.end_of_month
      @battle = Battle.find_by(year_month: date)
      if @battle
        render json: @battle, include: {
          dish: { only: [ :cuisine, :name ] },
          trash_talks: { include: {user: { only: :name } }, only: [ :created_at, :user, :trash ] },
          restaurants: { include: {votes: { include: { user: { only: :name } }, only: [ :created_at, :comment, :user ] } } }
          },
          status: :ok
      else
        render plain: "Battle for #{date.strftime('%B, %Y')} not found", status: :bad_request
      end
    end
  end

  def create
    begin
      raise error if !current_user
      date = Date.new(params[:battle][:year].to_i, params[:battle][:month].to_i, -1)
      @battle = Battle.create(year_month: date, dish: Dish.new(name: params[:battle][:dish_name], cuisine: params[:battle][:dish_cuisine]))
      render json: @battle, include: {
        dish: { only: [ :cuisine, :name ] },
        trash_talks: { include: {user: { only: :name } }, only: [ :created_at, :user, :trash ] },
        restaurants: { include: {votes: { include: { user: { only: :name } }, only: [ :created_at, :comment, :user ] } } }
        },
        status: :ok
    rescue
      render plain: 'Battle not created', status: :bad_request
    end      
  end

  def upvote
    begin
      user = current_user
      raise error if !user
      @battle = Battle.find_by(year_month: Date.today.end_of_month)
      @battle.restaurants.find(params[:vote][:restaurant_id]).votes << Vote.new(user: user, comment: params[:vote][:comment])
      @battle.save
      render json: @battle, include: {
        dish: { only: [ :cuisine, :name ] },
        trash_talks: { include: {user: { only: :name } }, only: [ :created_at, :user, :trash ] },
        restaurants: { include: {votes: { include: { user: { only: :name } }, only: [ :created_at, :comment, :user ] } } }
        },
        status: :ok
    rescue
      render plain: 'Upvote not registered', status: :bad_request
    end      
  end


end

