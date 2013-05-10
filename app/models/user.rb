class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :admin, :email, :password, :password_confirmation, :remember_me, :picture
  has_many :portfolios
  has_many :orders
  has_many :leagues, :through => :portfolios
  has_many :performances, :dependent => :destroy
  has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>", :tiny=>"55x55#" }, :default_url => "users/:style/missing.png"

  validates :name, :length => { :minimum => 4, :maximum => 50 }
  # attr_accessible :title, :body



  #Sorts a set of userIDs by date of the last message sent between them and the current user
  def self.sort_conversations(users,current_user)

    temp_array = []

    users.each do |user|
      msg = Message.where("(senderID = ? AND recipientID = ?) OR (senderID = ? AND recipientID = ?)",current_user.id,user,user,current_user.id).last
      temp_array.push([msg.date,user]) unless msg.nil?
    end

    temp_array.sort_by! {|x| x[0]}

    return temp_array.map{|new| new[1]}.reverse

  end

end
