class League < ActiveRecord::Base
  require 'money'
  attr_accessible :commission, :end_date, :member_limit, :margin, :capital, :name,
                  :private, :start_date, :creator_id
  attr_readonly :portfolios_count
  has_many :portfolios, :dependent => :destroy
  has_many :users, :through => :portfolios
  has_many :orders, :through => :portfolios

  monetize :margin_cents, :numericality => { :greater_than_or_equal_to => 0,
      :less_than_or_equal_to => 1000000 }
  monetize :commission_cents, :numericality => { :greater_than_or_equal_to => 0,
                                           :less_than_or_equal_to => 10000 }
  monetize :capital_cents, :numericality => { :greater_than_or_equal_to => 1000,
                                        :less_than_or_equal_to => 10000000 }

  validates :name, :uniqueness => true, :presence => true
  validates :private, :inclusion => {:in => [true, false]}
  validates :portfolios_count, :presence => true, :numericality => { :less_than_or_equal_to => :member_limit }

  validates :start_date, :presence => true
  validates :creator_id, :presence => true
  validates :end_date, :presence => true
  validate :end_date_greater_than_start_date

  def end_date_greater_than_start_date
    :end_date > :start_date
  end

  #validates :capital, :numericality => { :only_integer => true,
  #                        :greater_than_or_equal_to => 1000.to_money,
  #                        :less_than_or_equal_to => 1000000.to_money }
  #validates :margin, :numericality => { :only_integer => true,
  #                                       :greater_than_or_equal_to => 0.to_money,
  #                                       :less_than_or_equal_to => :capital }
  #validates :commission, :numericality => { :only_integer => true,
  #                                       :greater_than_or_equal_to => 0.to_money,
  #                                       :less_than_or_equal_to => 1000.to_money }

  #composed_of :commission,
  #            :class_name  => "Money",
  #            :mapping     => [%w(commission cents)],
  #            :constructor => Proc.new { |cents, currency| Money.new(cents || 0, Money.default_currency) },
  #            :converter   => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't conver #{value.class} to Money") }
  #
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

  private

  def full?
      self.member_number >= self.member_limit unless self.member_limit == nil
  end

end
