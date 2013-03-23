class Market < ActiveRecord::Base
  require 'money'
  attr_accessible :date, :name, :price
  monetize :price
  #composed_of :price,
  #            :class_name  => "Money",
  #            :mapping     => [%w(price cents)],
  #            :constructor => Proc.new { |cents, currency| Money.new(cents || 0, Money.default_currency) },
  #            :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't conver #{value.class} to Money") }
end
