FactoryGirl.define do
  factory :league do
	name "John's Test League"
	private false
	capital 100000
	margin   20000
	commission 50
	member_limit 1
	start_date Date.new(2013,4,1)
	end_date Date.new(2013,4,30)
	creator_id 0
  end
  
  factory :portfolio do
	manager false
	capital 0
	margin 0
	user_id 0
	league_id 0
  end
  
  factory :performance do
	date 0
	closing_value 100000
	closing_capital 0
	closing_margin 0
	portfolio_id 0
	league_id 0
  end

  factory :order do
    time_placed 0
    ticker "GOOG"
    price_executed 0
    quantity 0
    trade_type "buy"
    portfolio_id 0
    league_id 0
  end

  factory :user do
	name "John John"
	admin false
	email "johnjohn@test.com"
	password "testtest"

	factory :user_with_performances do


		after(:create) do |user, evaluator|
			l = FactoryGirl.create(:league, creator_id: user.id)
			po = FactoryGirl.create(:portfolio, user_id: user.id, league_id: l.id, 
								capital: l.capital, margin: l.margin)
			from_date = Date.new(2013,4,1)
			to_date = Date.current()
      c_cap = 100000
			(from_date..to_date).each do |d|
        if d.weekday?
          price = YahooFinance.get_historical_quotes("GOOG",d,d)
          c_cap = c_cap - price[0][4].to_f unless price[0].nil?
          FactoryGirl.create(:performance, date: d,	closing_capital: c_cap, league_id: l.id, portfolio_id: po.id) unless price[0].nil?
        end
      end
      (DateTime.now-30..DateTime.now).each do |d|
        price = YahooFinance.get_historical_quotes("GOOG",d,d)
        if d.weekday?
          FactoryGirl.create(:order, time_placed: d, ticker: "GOOG", price_executed: price[0][4].to_f, quantity: 1, trade_type: "buy", portfolio_id: po.id, league_id: l.id) unless price[0].nil?
        end
      end
		end
	end
  end
end