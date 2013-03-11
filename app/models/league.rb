class League < ActiveRecord::Base
  attr_accessible :commission, :end, :limits, :margin, :money, :name, :private, :start
end
