class ArticlesController < ApplicationController
  before_action :require_login, except: %i(index show)

  def index
    @user = User.active.find(params[:user_id]) if params[:user_id].present?
    respond_to do |format|
      format.html
      format.json {
        @form = ArticleSearchForm.new(current_user, @user, search_params)
        @articles = @form.articles(limit: 20, offset: params[:offset])
      }
    end
  end

  def show
    @article = Article.find(params[:id])
    raise NotFound unless @article.readable_by?(current_user)
  end

  def new
    @article = Article.new
    respond_to do |format|
      format.html
      format.json { render :show }
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :show }
    end
  end

  def create
    @article = Article.new
    @form = ArticleForm.new(current_user, @article, article_params)
    if @form.save
      flash.notice = '記事を作成しました。'
      render json: { location: article_path(@article) }
    else
      render json: { alert: '記事を作成できませんでした。', errors: @form.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def update
    @article = current_user.articles.find(params[:id])
    @form = ArticleForm.new(current_user, @article, article_params)
    if @form.save
      flash.notice = '記事を更新しました。'
      render json: { location: article_path(@article) }
    else
      render json: { alert: '記事を更新できませんでした。', errors: @form.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    @article.destroy
    redirect_to :articles, notice: '記事を削除しました。'
  end

  private
  def search_params
    return {} unless params.has_key?(:q)
    params.require(:q).permit(:title, :tag)
  end

  def article_params
    params.require(:article).permit(
      :title, :body, :published_at, :draft, tags: [ :name ]
    )
  end
end
