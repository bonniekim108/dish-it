class CreateSuggestionBoxes < ActiveRecord::Migration
  def change
    create_table :suggestion_boxes do |t|

      t.timestamps null: false
    end
  end
end
