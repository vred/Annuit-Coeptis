class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.boolean :private
      t.decimal :money
      t.decimal :margin
      t.decimal :commission
      t.integer :limits
      t.date :start
      t.date :end

      t.integer :user_id


      t.timestamps
    end
    add_index :leagues, [:user_id]
  end
end
