class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|

      t.timestamps null: false
    end
  end
end
