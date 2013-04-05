class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    # Lets make the comment_type = 1 if for league, 2 if for user, 3 if for company

    @comment = Comment.new(params[:comment])
    @comment.posted_at = DateTime.now
    @comment.user_id = current_user.id
    flash[:focus] = true
    

    respond_to do |format|
      if @comment.save
        if @comment.comment_type == 1
          format.html { redirect_to league_url(@comment.location_id), notice: 'Comment was successfully posted' }
        elsif @comment.comment_type == 2
          format.html { redirect_to user_url(@comment.location_id), notice: 'Comment was successfully posted' }
        elsif @comment.commene_type == 3
          format.html { redirect_to league_url(@comment.location_id), notice: 'Comment was successfully posted' }
        end

      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

  end
end
