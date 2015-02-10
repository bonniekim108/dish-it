require 'rails_helper'

RSpec.describe BattlesController, :type => :controller do
  before(:each) do
    auth_user = User.find_by(email: 'email@jim-clark.com')
    auth_user.token = 'testing-token'
    auth_user.save
    request.cookies[:dish_it_token] = 'testing-token'
  end
  let(:cur_year) { Date.today.year }
  let(:cur_month) { Date.today.month }
  let(:cur_eom_date) { Date.today.end_of_month }

  describe "GET #show" do

    it "returns latest current battle as json even if not logged in" do
      request.cookies[:dish_it_token] = nil
      get :show, {year: cur_year, month: cur_month}
      expect(JSON.parse(response.body)['year_month'].to_date).to eq(cur_eom_date)
    end

  end

  describe "POST #create" do
    let(:required_params) { { year: cur_year + 1, month: cur_month, dish_name: 'Test Dish Name', dish_cuisine: 'Test Cuisine' } }

    it "fails if not authenticated" do
      request.cookies[:dish_it_token] = nil
      post :create, battle: required_params
      expect(response.code).to eq('400')
    end

    it "creates a new battle with the required params" do
      post :create, battle: required_params
      battle = JSON.parse(response.body)
      expect( battle['year_month'].to_date ).to eq( Date.new(cur_year + 1, cur_month, -1) )
      expect( battle['dish'].to_json ).to eq( {name: 'Test Dish Name', cuisine: 'Test Cuisine'}.to_json )
    end

  end

  describe "POST #upvote" do
    before(:each) do
      @battle = Battle.includes(:restaurants).find_by(year_month: cur_eom_date)
    end
    let(:battle_id) { @battle.id }
    let(:rest_id) { @battle.restaurants.first.id }
    let(:required_params) { { vote: { restaurant_id: rest_id, comment: 'Comment for upvote :)' } } }

    it "fails if not authenticated" do
      request.cookies[:dish_it_token] = nil
      post :upvote, required_params
      expect(response.code).to eq('400')
    end

    it "adds a vote to an existing restaurant" do
      expect{ post :upvote, required_params }.to change{ Battle.find(battle_id).restaurants[0].votes.count }.by(1)
    end

  end


end
