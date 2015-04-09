class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  
  def new
    @page = current_user.pages.new
  end

  def create
    binding.pry
    tag = Tweet.pound_sign(params[:page][:hashtag])
    @page = current_user.pages.create(title: params[:page][:title], hashtag: tag, description: params[:page][:description])
    redirect_to edit_page_path(@page)
  end

  def edit
    @page = current_user.pages.find(params[:id])
  end

  def update
    @page = current_user.pages.find(params[:id])
    tag = Tweet.pound_sign(params[:page][:hashtag])
    if @page.update(title: params[:page][:title], hashtag: tag, description: params[:page][:description])
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


  private

  def page_params
    params.require(:page).permit!
  end

end 