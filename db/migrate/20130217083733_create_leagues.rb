class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.boolean :private
      t.money :capital
      t.money :margin
      t.money :commission
      t.integer :member_limit
      t.integer :count, :default => 0
      t.date :start_date
      t.date :end_date

      t.integer :creator_id


      t.timestamps
    end
    add_index :leagues, [:creator_id]
  end
end
