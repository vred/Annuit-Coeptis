class Market < ActiveRecord::Base
  require 'money'
  attr_accessible :date, :name, :price

  # Monetize eliminates the need to have a composed_of translation
  # also provides internal conversion
  # internally, the database appends "_cents" to a monetized attribute
  # depends on the Money and MoneyRails gems
  monetize :price_cents, :numericality => { :greater_than => 0}
end
