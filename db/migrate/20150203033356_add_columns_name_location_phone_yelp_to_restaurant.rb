class AddColumnsNameLocationPhoneYelpToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :name, :string
    add_column :restaurants, :location, :string
    add_column :restaurants, :phone, :string
    add_column :restaurants, :yelp_rating_photo_url, :string
    add_column :restaurants, :yelp_photo_url, :string
  end
end
