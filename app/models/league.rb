class League < ActiveRecord::Base
  attr_accessible :commission, :end, :limits, :margin, :money, :name, :private, :start
  has_many :portfolios
  has_many :users, :through => :portfolios
  has_many :orders, :through => :portfolios
end
