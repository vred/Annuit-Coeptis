FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar14"
    password_confirmation "foobar14"
  end

  factory :league do
    sequence(:name) { |n| "League #{n}" }
    commission 50
    limits 100
    margin 10000
    capital 100000
    private false
    start_date Time.zone.now
    end_date 10.weeks.from_now
  end

  # Need to research how to associate portfolios and leagues and users
  #factory :portfolio do
  #  capital 100000
  #  margin 10000
  #  instance_role false
  #end
end