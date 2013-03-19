class Orders < ActiveRecord::Base
  require 'money'
  attr_accessible :filled, :name, :placed, :price, :quantity, :type, :valid
  belongs_to :portfolio
  belongs_to :league
  composed_of :price,
              :class_name  => "Money",
              :mapping     => [%w(price cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't conver #{value.class} to Money") }
end
