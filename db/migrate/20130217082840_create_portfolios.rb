class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.boolean :manager, :default => false
      t.money :capital
      t.money :margin

      t.integer :user_id
      t.integer :league_id

      t.timestamps
    end
    add_index :portfolios, [:user_id, :league_id]
  end
end
