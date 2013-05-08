class AddAttachmentIconToLeagues < ActiveRecord::Migration
  def self.up
    change_table :leagues do |t|
      t.attachment :icon
    end
  end

  def self.down
    drop_attached_file :leagues, :icon
  end
end
