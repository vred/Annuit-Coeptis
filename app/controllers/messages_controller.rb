class MessagesController < ApplicationController

  def index
    @messages = Message.where("recipientID=? OR senderID=?",current_user.id, current_user.id)

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
    @message.recipientID = User.where("name = ?", @message.name).first.id
    @message.date = DateTime.now
    if @message.save
      # Flash a success message
      flash[:success] = "Sent your message!"
      # Send them to the league
      redirect_to @message
    else
      @message.delete
      flash[:fail] = "Sorry, that didn't work!"
      render 'new'
    end
  end

end