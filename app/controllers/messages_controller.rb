class MessagesController < ApplicationController

  def index
    userids = User.select("id")
    userids = userids.map(&:id)
    messages = Message.select("recipientID").where("senderID=?",current_user.id)
    messages = messages.map(&:recipientID)
    messages2 = Message.select("senderID").where("recipientID=?",current_user.id)
    messages2 = messages2.map(&:senderID)
    messages = messages.concat(messages2)
    userids = userids & messages
    @conversations = User.find(userids)
  end

  def show
    @message = Message.find(params[:id])


  end

  def new
    @message = Message.new
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