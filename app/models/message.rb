class Message < ActiveRecord::Base
  attr_accessible :date, :message, :recipientID, :senderID, :username
end
