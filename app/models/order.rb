class Order < ActiveRecord::Base
  require 'money'
  attr_accessible :time_filled, :ticker, :time_placed, :price_executed, :quantity, :type, :trade_type

  validates :ticker, :presence => true, :length => { :maximum => 5 }
  validate :filled_date_greater_than_placed_date
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :time_placed, :presence => true

  belongs_to :portfolio
  belongs_to :league
  monetize :price
  #composed_of :price,
  #            :class_name  => "Money",
  #            :mapping     => [%w(price cents)],
  #            :constructor => Proc.new { |cents, currency| Money.new(cents || 0, Money.default_currency) },
  #            :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't conver #{value.class} to Money") }

  def filled_date_greater_than_placed_date
    :end_date > :start_date
  end
end

class MarketOrders < Order

end

class StopOrders < Order
  attr_accessible :expiration_date, :threshold_price, :valid_order
end

class LimitOrders < Order
  attr_accessible :expiration_date, :threshold_price, :valid_order
end
