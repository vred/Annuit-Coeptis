class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment
      t.integer :user_id
      t.integer :comment_type
      t.integer :location_id
      t.datetime :posted_at

      t.timestamps
    end
  end
end
