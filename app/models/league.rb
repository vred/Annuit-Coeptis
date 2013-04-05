class League < ActiveRecord::Base
  attr_accessible :commission, :end_date, :member_limit, :margin, :capital, :name,
                  :private, :start_date, :creator_id
  attr_readonly :portfolios_count
  has_many :portfolios, :dependent => :destroy
  has_many :users, :through => :portfolios
  has_many :orders, :through => :portfolios


  # Monetize eliminates the need to have a composed_of translation
  # also provides internal conversion
  # internally, the database appends "_cents" to a monetized attribute
  # depends on the Money and MoneyRails gems
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

  private

  def full?
      self.member_number >= self.member_limit unless self.member_limit == nil
  end

end
