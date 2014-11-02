class ArticlesController < ApplicationController

  http_basic_authenticate_with name: 'quanpower', password: 'caojing1010',except: [:index, :show]
  # 简单的http身份认证
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
    @article = Article.find(params[:id])
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text, :article_image, :article_image_cache, :remote_article_image_url)
    end
end
