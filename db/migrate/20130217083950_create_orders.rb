class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.money :price
      t.integer :quantity
      t.string :type
      t.datetime :placed
      t.datetime :filled
      t.integer :valid

      t.integer :portfolio_id
      t.integer :league_id

      t.timestamps
    end
    add_index :orders, [:portfolio_id, :league_id]
  end
end
