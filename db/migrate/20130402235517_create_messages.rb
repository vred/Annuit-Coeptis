class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message
      t.integer :senderID
      t.integer :recipientID
      t.datetime :date

      t.timestamps
    end
  end
end
