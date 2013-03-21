class Portfolio < ActiveRecord::Base
  require 'money'
  require 'money-rails'
  attr_accessible :capital, :margin, :manager
  belongs_to :user
  belongs_to :league
  has_many :orders, :dependent => :destroy

  monetize :capital, :margin

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

  after_create do
    @league = League.find(:league_id)
    @league.increment_users
  end

  after_destroy do
    @league = League.find(:league_id)
    @league.decrement_users
  end

  private

  def manager?
      self.role
  end
end
