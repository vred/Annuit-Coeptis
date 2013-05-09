class AddAttachmentPictureToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :users, :picture
  end
end
