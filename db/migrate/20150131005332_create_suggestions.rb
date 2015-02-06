class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.belongs_to :potential_dish, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
