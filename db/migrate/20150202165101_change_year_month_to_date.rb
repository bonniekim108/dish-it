class ChangeYearMonthToDate < ActiveRecord::Migration
  def change
    remove_column :battles, :year_month, :string
    add_column :battles, :year_month, :date
  end
end
