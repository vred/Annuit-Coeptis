require 'spec_helper'

describe League do
  before do
    @user = User.new(name: "Example", email: "user@example.com",
                     password: "foobar14", password_confirmation: "foobar14")
    @user.save
    @league = League.new(name: "League", private: false, commission: 100,
                        start_date: Time.zone.now, end_date: 10.weeks.from_now,
                      capital: 100000, margin: 10000, member_limit: 100, creator_id: @user.id)
  end

  subject { @league }

  it { should respond_to(:name) }
  it { should respond_to(:private) }
  it { should respond_to(:commission) }
  it { should respond_to(:start_date) }
  it { should respond_to(:end_date) }
  it { should respond_to(:capital) }
  it { should respond_to(:margin) }
  it { should respond_to(:member_limit) }
  it { should respond_to(:count) }
  it { should respond_to(:creator_id) }

  describe "when name is not present" do
    before { @league.name = " " }
    it { should_not be_valid }
  end

  describe "when privacy not set" do
    before { @league.private = nil }
    it { should_not be_valid }
  end

  describe "when start date not present" do
    before { @league.start_date = nil }
    it { should_not be_valid }
  end

  describe "when end date is not present" do
    before { @league.end_date = nil }
    it { should_not be_valid }
  end

  describe "when margin is negative" do
    before { @league.margin = -1 }
    it { should_not be_valid }
  end

  describe "when commission is too small" do
    before { @league.commission = -1 }
    it { should_not be_valid }
  end

  describe "when capital is too small" do
    before { @league.capital = 999 }
    it { should_not be_valid }
  end

  describe "when margin is too large" do
    before { @league.margin = 10000001 }
    it { should_not be_valid }
  end

  describe "when commission is too large" do
    before { @league.commission = 10000001 }
    it { should_not be_valid }
  end

  describe "when end date is less than start date" do
    before do
      @league.end_date = Time.zone.now
      @league.start_date = 1.day.from_now
    end
    it { should_not be_valid }
  end

  describe "when league is full" do
    before { @league.count = @league.member_limit + 1 }
    it { should_not be_valid }
  end
end
