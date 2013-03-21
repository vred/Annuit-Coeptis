require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example", email: "user@example.com",
                        password: "foobar14", password_confirmation: "foobar14")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:admin) }
  it { should respond_to(:remember_me) }

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

 describe "when email format is valid" do
   it "should_be valid" do
     addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
     addresses.each do |valid_address|
       @user.email = valid_address
       @user.should be_valid
     end
   end
 end

 describe "when email address is already taken" do
   before do
     user_with_same_email = @user.dup
     user_with_same_email.email = @user.email.upcase
     user_with_same_email.save
   end

   it { should_not be_valid }
 end

 describe "when password is not present" do
   before { @user.password = @user.password_confirmation = " " }
   it { should_not be_valid }
 end

  # This test fails internally but the action seems to be
  # prohibited by Devise anyway, not sure what to make of it
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
end
