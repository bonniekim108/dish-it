class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.has_many :votes, index: true
      t.has_many :restaurants, index: true

      t.timestamps null: false
    end
  end
end
