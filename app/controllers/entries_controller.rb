class EntriesController < ApplicationController
  before_action :require_login, except: %i(index show)

  def index
    @user = User.active.find(params[:user_id]) if params[:user_id].present?
    @form = Entries::SearchForm.new(current_user, @user, search_params)
    respond_to :html, :json
  end

  def show
    @entry = Entry.find(params[:id])
    raise NotFound unless @entry.readable_by?(current_user)
  end

  def new
    @entry = Entry.new
    @form = Entries::Form.new(current_user, @entry)
    respond_to do |format|
      format.html
      format.json { render :edit }
    end
  end

  def edit
    @entry = current_user.entries.find(params[:id])
    @form = Entries::Form.new(current_user, @entry)
    respond_to :html, :json
  end

  def create
    @entry = Entry.new
    @form = Entries::Form.new(current_user, @entry, entry_params)
    if @form.save
      render json: { location: entry_path(@entry), notice: '記事を作成しました。' }
    else
      render json: { alert: '記事を作成できませんでした。' },
        status: :unprocessable_entity
    end
  end

  def update
    @entry = current_user.entries.find(params[:id])
    @form = Entries::Form.new(current_user, @entry, entry_params)
    if @form.save
      render json: { location: entry_path(@entry), notice: '記事を更新しました。' }
    else
      render json: { alert: '記事を更新できませんでした。' },
        status: :unprocessable_entity
    end
  end

  def destroy
    @entry = current_user.entries.find(params[:id])
    @entry.destroy
    render json: { location: user_entries_path(current_user), notice: '記事を削除しました。' }
  end

  private
  def search_params
    params.except(:user_id, :format).permit(:title, :tag, :offset, :sort)
  end

  def entry_params
    params.require(:entry).permit(
      :title, :body, :published_at, :draft, tags: [ :name ]
    )
  end
end
