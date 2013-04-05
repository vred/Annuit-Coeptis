class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :ticker
      t.money :price_executed
      t.money :threshold_price
      t.integer :quantity
      t.string :type
      t.datetime :time_placed
      t.datetime :time_filled
      t.integer :duration_valid
      t.boolean :valid_order
      t.string :trade_type

      t.integer :portfolio_id
      t.integer :league_id

      t.timestamps
    end
    add_index :orders, [:portfolio_id, :league_id]
  end
end
