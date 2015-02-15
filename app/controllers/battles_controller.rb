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
          restaurants: { include: {votes: { include: { user: { only: [:id, :name] } }, only: [ :created_at, :comment, :user ] } } }
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
        restaurants: { include: {votes: { include: { user: { only: [:id, :name] } }, only: [ :created_at, :comment, :user ] } } }
        },
        status: :ok
    rescue
      render plain: 'Battle not created', status: :bad_request
    end      
  end

  def winners
    date = Date.today.end_of_month
    @battles = Battle.all.where(["year_month < ?", date]).order(year_month: :desc)
    if @battles
      render json: @battles, include: {
        dish: { only: [ :cuisine, :name ] },
        trash_talks: { include: {user: { only: :name } }, only: [ :created_at, :user, :trash ] },
        restaurants: { include: {votes: { include: { user: { only: [:id, :name] } }, only: [ :created_at, :comment, :user ] } } }
        },
        status: :ok
    else
      render plain: "No winners exist", status: :bad_request
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
        restaurants: { include: {votes: { include: { user: { only: [:id, :name] } }, only: [ :created_at, :comment, :user ] } } }
        },
        status: :ok
    rescue
      render plain: 'Upvote not registered', status: :bad_request
    end      
  end

  def nominate
    begin
      user = current_user
      raise error if !user
      @battle = Battle.find_by(year_month: Date.today.end_of_month)
      restaurant = Restaurant.new(nominate_params.except(:comment))
      restaurant.votes << Vote.new(user: user, comment: params[:nominate][:comment])
      @battle.restaurants << restaurant
      @battle.save
      render json: @battle, include: {
        dish: { only: [ :cuisine, :name ] },
        trash_talks: { include: {user: { only: :name } }, only: [ :created_at, :user, :trash ] },
        restaurants: { include: {votes: { include: { user: { only: [:id, :name]} }, only: [ :created_at, :comment, :user ] } } }
        },
        status: :ok
    rescue
      render plain: 'Nomination not registered', status: :bad_request
    end   
  end

  def add_trash
    begin
      user = current_user
      raise error if !user
      @battle = Battle.find_by(year_month: Date.today.end_of_month)
      @battle.trash_talks << TrashTalk.new(user: user, trash: params[:trash])
      @battle.save
      render json: @battle, include: {
        dish: { only: [ :cuisine, :name ] },
        trash_talks: { include: {user: { only: :name } }, only: [ :created_at, :user, :trash ] },
        restaurants: { include: {votes: { include: { user: { only: [:id, :name]} }, only: [ :created_at, :comment, :user ] } } }
        },
        status: :ok
    rescue
      render plain: 'Trash not added', status: :bad_request
    end   
  end

  private

  def nominate_params 
    return params.require(:nominate).permit(:name, :location, :phone, :yelp_rating_photo_url, :yelp_photo_url, :comment)
  end

end

