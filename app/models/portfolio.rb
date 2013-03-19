class Portfolio < ActiveRecord::Base
  require 'money'
  attr_accessible :capital, :margin, :role
  belongs_to :user
  belongs_to :league
  has_many :orders

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

  validates :capital, presence: true
  validates :margin, presence: true

  private

  def manager?
      self.role
  end
end
