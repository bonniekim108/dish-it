class AddUtcOffsetForCounty < ActiveRecord::Migration
  def change
    add_column :counties, :UTC_offset, :integer
  end
end
