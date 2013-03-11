class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :role
      t.decimal :capital
      t.decimal :margin

      t.integer :user_id
      t.integer :league_id

      t.timestamps
    end
    add_index :portfolios, [:user_id, :league_id]
  end
end
