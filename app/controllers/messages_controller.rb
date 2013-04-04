class MessagesController < ApplicationController

  def index
    userids = User.select("id")
    userids = userids.map(&:id)
    messages = Message.select("recipientID").where("senderID = ?",current_user.id)
    messages = messages.map(&:recipientID)
    messages2 = Message.select("senderID").where("recipientID = ?",current_user.id)
    messages2 = messages2.map(&:senderID)
    messages = messages.concat(messages2)
    userids = userids & messages
    @conversations = User.sort_conversations(User.find(userids),current_user)
  end

  def show
    message = Message.find(params[:id])
    # Choose the messages that are between the current user and the message to be shown
    # This will create a "conversation" of all the messages these two users have sent between one another
    if message.senderID == current_user.id
      @set_of_msg = Message.where("(senderID = ? AND recipientID = ?) OR (senderID = ? AND recipientID = ?)",message.recipientID,current_user.id,current_user.id,message.recipientID).reverse
      @recipient = message.recipientID
    elsif message.recipientID == current_user.id
      @set_of_msg = Message.where("(senderID = ? AND recipientID = ?) OR (senderID = ? AND recipientID = ?)",message.senderID,current_user.id,current_user.id,message.senderID).reverse
      @recipient = message.senderID
    else
      flash[:fail] = "Something went wrong!"
      render 'new'
    end
  end

  def new
    @message = Message.new
    @send_to = params[:send_to]
  end

  def create
    @message = Message.new(params[:message])
    @message.senderID = current_user.id
    if User.where("name = ?", @message.username).exists?
      @message.recipientID = User.where("name = ?", @message.username).first.id
    else
      flash[:fail] = "Sorry, that user doesn't exist!"
      @message.delete
      render 'new'
      return
    end
    @message.date = DateTime.now
    if @message.save
      # Flash a success message
      flash[:success] = "Sent your message!"
      redirect_to @message
    else
      @message.delete
      flash[:fail] = "Sorry, that didn't work!"
      render 'new'
    end
  end

end