class Portfolio < ActiveRecord::Base
  require 'money'
  require 'money-rails'
  attr_accessible :capital, :margin, :manager, :user_id, :league_id
  belongs_to :user
  belongs_to :league, :counter_cache => true
  has_many :orders, :dependent => :destroy
  has_many :performances, :dependent => :destroy


  # Monetize eliminates the need to have a composed_of translation
  # also provides internal conversion
  # internally, the database appends "_cents" to a monetized attribute
  # depends on the Money and MoneyRails gems
  monetize :capital_cents, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :margin_cents, :numericality => { :greater_than_or_equal_to => 0 }



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
