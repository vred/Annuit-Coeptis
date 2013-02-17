class Portfolio < ActiveRecord::Base
  attr_accessible :capital, :margin, :role
  belongs_to :user
  belongs_to :league
  has_many :orders

  validates :capital, presence: true
  validates :margin, presence: true
end
