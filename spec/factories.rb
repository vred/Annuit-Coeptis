FactoryGirl.define do
  factory :league do
	name "Factory Test League"
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
	closing_capital 5000
	closing_margin 0
	portfolio_id 0
	league_id 0
  end
  
  factory :user do
	name "John Doe"
	admin false
	email "factorytester@example.com"
	password "ilovekitties"
	
	factory :user_with_performances do
	
		
		after(:create) do |user, evaluator|
			l = FactoryGirl.create(:league, creator_id: user.id)
			po = FactoryGirl.create(:portfolio, user_id: user.id, league_id: l.id, 
								capital: l.capital, margin: l.margin)
			from_date = Date.new(2013,4,1)
			to_date = Date.current()
			(from_date..to_date).each do |d|
				FactoryGirl.create(:performance, date: d,	league_id: l.id, portfolio_id: po.id) if d.weekday? 
			end					
		end
	end
  end
end