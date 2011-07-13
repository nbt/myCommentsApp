class CommentsController < ApplicationController

  def index
    @comments = Comment.all
    # index.html.erb
  end

  def create
    @comment = Comment.create!(params[:comment])
    flash[:notice] = "Thanks for commenting!"
    respond_to do |format|
      format.html { redirect_to comments_path } # index.html.erb
      format.js                                 # create.js.erb
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_path } # index.html.erb
      format.js                                 # destroy.js.erb
    end
  end
    
end
