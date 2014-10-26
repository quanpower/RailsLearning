class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def create
    @article = Article.new(article_params) #健壮参数,模型属性初始化，映射到数据库

    if @article.save
      redirect_to @article #转到show页面
    else
      render 'new'
    end
  end

  def new
    @article = Article.new
  end

  def edit

  end

  def show
    @article = Article.find(params[:id])
  end

  def update

  end

  def destroy

  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
