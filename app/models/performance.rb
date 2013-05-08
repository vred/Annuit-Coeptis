class Performance < ActiveRecord::Base
  require 'money'
  require 'money-rails'
  attr_accessible :date, :closing_value, :closing_capital, :closing_margin, :league_id, :portfolio_id
  belongs_to :league
  belongs_to :portfolio
  
  monetize :closing_value_cents, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :closing_capital_cents, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :closing_margin_cents, :numericality => { :greater_than_or_equal_to => 0 }
  
end