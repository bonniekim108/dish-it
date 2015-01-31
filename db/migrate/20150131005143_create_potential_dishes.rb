class CreatePotentialDishes < ActiveRecord::Migration
  def change
    create_table :potential_dishes do |t|
      t.string :name
      t.string :cuisine

      t.timestamps null: false
    end
  end
end
