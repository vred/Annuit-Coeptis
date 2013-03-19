class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.string :name
      t.datetime :date
      t.integer :price

      t.timestamps
    end
  end
end
