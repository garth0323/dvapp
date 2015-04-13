class PagesController < ApplicationController
  before_action :authenticate_user!, except: :published
  before_action :all_pages
  
  def new
    @page = Page.new
  end

  def create
    tag = Tweet.pound_sign(params[:page][:hashtag])
    @page = current_user.pages.create(title: params[:page][:title], hashtag: tag, description: params[:page][:description], subdomain: params[:page][:subdomain])
    redirect_to edit_page_path(@page)
  end

  def edit
    @page = current_user.pages.find(params[:id])
  end

  def update
    @page = current_user.pages.find(params[:id])
    tag = Tweet.pound_sign(params[:page][:hashtag])
    if @page.update(title: params[:page][:title], hashtag: tag, description: params[:page][:description], subdomain: params[:page][:subdomain])
      redirect_to @page, notice: 'Page was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def show
    @page = current_user.pages.find(params[:id])
    start = TwitterApi.new
    @hashtag = @page.hashtag
    hash_response = start.response(@hashtag)
    @next_url = hash_response["next_url"]
    @tweets = hash_response["data"]
  end

  def index
    @pages = current_user.pages
  end

  def new_post
    @post = Post.upload_from_twitter(params[:data], params[:page])
  end

  def published
    @page = Page.find_by subdomain: (request.subdomain)
    @disable_nav = true
  end


  private

  def page_params
    params.require(:page).permit!
  end

  def all_pages
    @user_tags = current_user.pages
  end

end 