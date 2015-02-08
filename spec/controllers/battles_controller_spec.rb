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

end
