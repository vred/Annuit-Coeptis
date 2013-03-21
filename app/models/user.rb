class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :admin, :email, :password, :password_confirmation, :remember_me
  has_many :portfolios
  has_many :orders
  has_many :leagues, :through => :portfolios

  validates :name, :length => { :minimum => 4, :maximum => 50 }
  # attr_accessible :title, :body
end
