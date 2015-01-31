class CreateTrashTalks < ActiveRecord::Migration
  def change
    create_table :trash_talks do |t|
      t.string :trash

      t.timestamps null: false
    end
  end
end
