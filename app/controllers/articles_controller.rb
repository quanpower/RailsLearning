class ArticlesController < ApplicationController
  def index

  end

  def create
    @article = Article.new(params[:article])

    @artcile.save
    redirect_to @article
  end

  def new

  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end


end
