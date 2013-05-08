class ChangePerformanceDatetimeToDate < ActiveRecord::Migration
  def up
    change_column :performances, :date, :date
  end

  def down
    change_column :performances, :date, :datetime
  end
end
