require 'rails_helper'

RSpec.describe BattlesController, :type => :controller do
  let(:cur_year) { Date.today.year }
  let(:cur_month) { Date.today.month }

  describe "GET #show" do
    let(:expected_results) { Battle.to_json }

    it "returns json" do
      get :show, {year: cur_year, month: cur_month}
      expect {JSON.parse(response.body)}.to_not raise_error
    end

  end

  describe "POST #create" do
    let(:required_params) { { year: cur_year + 1, month: cur_month, dish_name: 'Test Dish Name', dish_cuisine: 'Test Cuisine' } }

    it "creates a new battle with the required params" do
      post :create, battle: required_params
      battle = JSON.parse(response.body)
      expect( battle['year_month'].to_date ).to eq( Date.new(cur_year + 1, cur_month, -1) )
      expect( battle['dish'].to_json ).to eq( {name: 'Test Dish Name', cuisine: 'Test Cuisine'}.to_json )
    end

  end


end
