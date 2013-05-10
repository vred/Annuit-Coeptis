class Order < ActiveRecord::Base
  require 'money'
  attr_accessible :time_filled, :ticker, :price_executed, :quantity, :order_type,
                  :trade_type, :portfolio_id, :league_id
  attr_reader :created_at

  validates :ticker, :presence => true, :length => { :maximum => 5 }
  validate :filled_date_greater_than_placed_date
  validates :quantity, :numericality => { :greater_than => 0 }
  validates :time_placed, :presence => true

  belongs_to :portfolio
  belongs_to :league
  # Monetize eliminates the need to have a composed_of translation
  # also provides internal conversion
  # internally, the database appends "_cents" to a monetized attribute
  # depends on the Money and MoneyRails gems
  monetize :price_executed_cents, :numericality => { :greater_than => 0 }

  def filled_date_greater_than_placed_date
    :time_filled > :time_placed if :time_filled and :time_placed
  end


  def self.find_positions(portfolio_id)

    return find_positions_by_date(portfolio_id, DateTime.now())

  end


  def self.find_positions_by_date(portfolio_id, date)

    orders = Order.where("portfolio_id = ? and time_placed <= ?",portfolio_id, date)
    orders = orders.group_by{|x| x.ticker}
    keys = orders.keys

    ticker_totals = []

    keys.each do |key|

      temp_array = orders[key]

      temp_array.each do |temp|

        if temp.trade_type == "sell"
          temp.quantity = -1*temp.quantity
        end


      end

      order_array = temp_array.map{|f| f.quantity}

      total = order_array.inject(:+)

      ticker_totals.push([key,total])

    end

    return ticker_totals


  end

  def self.find_history(portfolio_id)


    graphing_data = []

    orders = Order.where("portfolio_id = ?",portfolio_id)
    orders = orders.group_by{|x| x.ticker}
    keys = orders.keys
    data_by_key = {}
    keys.each do |key|

      finance_data = YahooFinance::get_historical_quotes_days(key, 30)
      finance_data = finance_data.map{|new_data| [Time.parse(new_data[0]).to_i*1000, new_data[4].to_f]}.sort_by{|d| d[0]}
      data_by_key[key] = finance_data

    end

    i=0
    prev = 0

    performances = Performance.where(:portfolio_id=>portfolio_id).last(30)

    p_hash = {}

    performances.each do |performance|

      p_hash[performance.date] = performance

    end

    for d in DateTime.now()-29..DateTime.now()

      d_positions = find_positions_by_date(portfolio_id, d)


      d_total=0

      for j in 0..13
        if d_total == 0
          the_day = p_hash[Date.parse(d.to_s)-j]
          unless the_day.nil?
            d_total = the_day.closing_capital_cents/100 #this their total worth for that day
          end
        end
      end

      d_positions.each do |d_position|

        unless d_position.nil?
            unless data_by_key[d_position[0]][i].nil?
              if Date.parse(d.to_s).weekday?
                d_total += d_position[1] * data_by_key[d_position[0]][i][1]
                prev = d_total
                i = i + 1
              else
                d_total = prev
              end

            end
        end


      end


      graphing_data.push([Time.parse(d.to_s).to_i*1000,d_total])

    end

    return graphing_data

  end



end



class MarketOrder < Order

end

class StopOrder < Order
  attr_accessible :duration_valid, :threshold_price, :valid_order
  monetize :threshold_price_cents, :numericality => { :greater_than => 0 }
end

class LimitOrder < Order
  attr_accessible :duration_valid, :threshold_price, :valid_order
  monetize :threshold_price_cents, :numericality => { :greater_than => 0 }
end
