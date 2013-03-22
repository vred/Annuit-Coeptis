class Portfolio < ActiveRecord::Base
  require 'money'
  require 'money-rails'
  attr_accessible :capital, :margin, :manager, :user_id, :league_id
  belongs_to :user
  belongs_to :league, :counter_cache => true
  has_many :orders, :dependent => :destroy

  monetize :capital_cents, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :margin_cents, :numericality => { :greater_than_or_equal_to => 0 }

  #composed_of :capital,
  #            :class_name  => "Money",
  #            :mapping     => [%w(capital cents)],
  #            :constructor => Proc.new { |cents, currency| Money.new(cents || 0, Money.default_currency) },
  #            :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't conver #{value.class} to Money") }
  #
  #composed_of :margin,
  #            :class_name  => "Money",
  #            :mapping     => [%w(margin cents)],
  #            :constructor => Proc.new { |cents, currency| Money.new(cents || 0, Money.default_currency) },
  #            :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't conver #{value.class} to Money") }

  validates :capital, presence: true
  validates :margin, presence: true
  validates :user_id, presence: true
  validates :league_id, presence: true

  after_create do
    League.increment_counter(:portfolios_count, :league_id)
  end

  after_destroy do
    League.decrement_counter(:portfolios_count, :league_id)
  end
end
