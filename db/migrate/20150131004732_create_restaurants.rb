class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.belongs_to :battle, index: true
      t.timestamps null: false
    end
  end
end
