class CreateTrashTalks < ActiveRecord::Migration
  def change
    create_table :trash_talks do |t|
      t.string :trash
      t.belongs_to :user, index: true
      t.belongs_to :battle, index: true
      t.timestamps null: false
    end
  end
end
