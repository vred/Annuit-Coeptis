class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
	  t.datetime :date
	  t.money :closing_value
	  t.money :closing_capital
	  t.money :closing_margin
	  
	  t.integer :portfolio_id
	  t.integer :league_id
	
      t.timestamps
    end
  end
end
