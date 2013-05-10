class League < ActiveRecord::Base
  attr_accessible :commission, :end_date, :member_limit, :margin, :capital, :name,
                  :private, :start_date, :creator_id, :description, :icon
  attr_readonly :portfolios_count
  has_many :portfolios, :dependent => :destroy
  has_many :users, :through => :portfolios
  has_many :orders, :through => :portfolios
  has_many :performances, :dependent => :destroy
  has_attached_file :icon, :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny=>"55x55#" }, :default_url => "leagues/:style/missing.jpg"


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

  def self.find_rank(portfolio_id, league_id)

    members = Portfolio.where("league_id = ?",league_id)

    leaders = []

    members.each do |m|

      d_positions = Order.find_positions(m.id)

      orders = Order.where("portfolio_id = ?",portfolio_id)
      orders = orders.group_by{|x| x.ticker}
      keys = orders.keys
      data_by_key = {}
      keys.each do |key|

        finance_data = YahooFinance::get_historical_quotes_days(key, 30)
        finance_data = finance_data.map{|new_data| [Time.parse(new_data[0]).to_i*1000, new_data[4].to_f]}.sort_by{|d| d[0]}
        data_by_key[key] = finance_data

      end

      d_total = Performance.today(m.id)

      prev = 0

      d_positions.each do |d_position|

        unless d_position.nil?
          unless data_by_key[d_position[0]][0].nil?
              d_total += d_position[1] * data_by_key[d_position[0]][0][1]
              prev = d_total
            else
              d_total = prev
            end

        end

      end

      leaders.push([m,d_total])

    end

    leaders.sort_by{|x| x[1]}.reverse

    x=1

    leaders.each do |me|

      if me[0].id == portfolio_id

        return x

      end

      x += 1

    end

  end

end
