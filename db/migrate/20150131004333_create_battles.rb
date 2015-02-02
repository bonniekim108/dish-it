class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.string :year_month

      t.timestamps null: false
      add_column :battles, :name, :string    
    end
  end
end
