class Orders < ActiveRecord::Base
  attr_accessible :filled, :name, :placed, :price, :quantity, :type, :valid
  belongs_to :portfolio
  belongs_to :league
end
