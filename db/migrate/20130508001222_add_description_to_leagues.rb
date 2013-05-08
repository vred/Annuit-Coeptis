class AddDescriptionToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :description, :string
  end
end
