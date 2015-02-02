class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name
      t.has_many :users, index: true
      t.timestamps null: false
    end
  end
end
