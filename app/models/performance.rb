class Performance < ActiveRecord::Base
  require 'money'
  require 'money-rails'
  attr_accessible :date, :closing_value, :closing_capital, :closing_margin, :league_id, :portfolio_id
  belongs_to :league
  belongs_to :portfolio
  
  monetize :closing_value_cents, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :closing_capital_cents, :numericality => { :greater_than_or_equal_to => 0 }
  monetize :closing_margin_cents, :numericality => { :greater_than_or_equal_to => 0 }


  def self.today(portfolio_id)

    perf = 0
    for j in 0..13
      if perf == 0
        the_day = Performance.where(:portfolio_id=>portfolio_id).where(:date=>Date.today-j).first
        unless the_day.nil?
          perf = the_day.closing_capital_cents/100 #this their total worth for that day
        end
      end
    end
    return perf
  end

end