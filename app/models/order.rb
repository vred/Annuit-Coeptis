class Order < ActiveRecord::Base
  require 'money'
  attr_accessible :time_filled, :ticker, :price_executed, :quantity, :type,
                  :trade_type, :portfolio_id, :league_id
  attr_reader :created_at

  validates :ticker, :presence => true, :length => { :maximum => 5 }
  validate :filled_date_greater_than_placed_date
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :time_placed, :presence => true

  belongs_to :portfolio
  belongs_to :league
  # Monetize eliminates the need to have a composed_of translation
  # also provides internal conversion
  # internally, the database appends "_cents" to a monetized attribute
  # depends on the Money and MoneyRails gems
  monetize :price_executed_cents, :numericality => { :greater_than => 0 }

  def filled_date_greater_than_placed_date
    :time_filled > :time_placed if :time_filled and :time_placed
  end
end

class MarketOrders < Order

end

class StopOrders < Order
  attr_accessible :duration_valid, :threshold_price, :valid_order
  monetize :threshold_price_cents, :numericality => { :greater_than => 0 }
end

class LimitOrders < Order
  attr_accessible :duration_valid, :threshold_price, :valid_order
  monetize :threshold_price_cents, :numericality => { :greater_than => 0 }
end
