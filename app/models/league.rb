class League < ActiveRecord::Base
  require 'money'
  attr_accessible :commission, :end, :limits, :margin, :capital, :name, :private, :start
  has_many :portfolios
  has_many :users, :through => :portfolios
  has_many :orders, :through => :portfolios

  composed_of :commission,
              :class_name  => "Money",
              :mapping     => [%w(commission cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't conver #{value.class} to Money") }

  composed_of :capital,
              :class_name  => "Money",
              :mapping     => [%w(capital cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't conver #{value.class} to Money") }

  composed_of :margin,
              :class_name  => "Money",
              :mapping     => [%w(margin cents), %w(currency currency_as_string)],
              :constructor => Proc.new { |cents, currency| Money.new(cents || 0, currency || Money.default_currency) },
              :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't conver #{value.class} to Money") }
end
