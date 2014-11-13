class CommentsController < ApplicationController

  before_filter :require_user

  def index
    redirect_to channel_path(:id => params[:channel_id], :public => true)
  end


  def create
    render :text => '' and return if params[:userlogin].length > 0

    @channel = Channel.find(params[:channel_id])
    @comment = @channel.comments.new
    @comment.user = current_user
    @comment.ip_address = get_header_value('X_REAL_IP')
    @comment.parent_id = params[:parent_id]
    @comment.body = params[:comment][:body].gsub(/<\/?[^>]*>/, '').gsub(/\n/, '<br /')

    # save comment
    if @comment.save
      flash[:notice] = "Thanks for adding a comment!"
    else
      flash[:alert] = "Comment can't be blank!"
    end
    redirect_to :back
  end

  

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
