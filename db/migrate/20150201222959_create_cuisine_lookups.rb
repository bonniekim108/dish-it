class CreateCuisineLookups < ActiveRecord::Migration
  def change
    create_table :cuisine_lookups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
