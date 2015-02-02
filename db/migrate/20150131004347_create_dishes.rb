class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :cuisine
      t.belongs_to :battle, index: true
      t.timestamps null: false
    end
  end
end
