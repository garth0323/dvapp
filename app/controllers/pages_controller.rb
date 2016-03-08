class PagesController < ApplicationController
  before_action :authenticate_user!, except: :published
  before_action :all_pages, except: :published
  
  def new
    @page = Page.new
  end

  def create
    @page = current_user.pages.create(page_params)
    redirect_to edit_page_path(@page)
  end

  def edit
    @page = current_user.pages.find(params[:id])
  end

  def update
    @page = current_user.pages.find(params[:id])
    respond_to do |format| 
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { respond_with_bip(@page) }
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@page) }
      end
    end
  end

  def show
    @page = current_user.pages.find(params[:id])
    @hashtag = @page.hashtag
    response = CombinedResponse.return_hashtag_json(@hashtag)
    @next_url = response["next_url"]
    sorted = response["posts"].sort { |x,y| y[:created] <=> x[:created] }
    @posts = sorted
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
    @posts = @page.posts
  end

  def example
    @page = current_user.pages.find(params[:id])
    @posts = @page.posts
  end


  private

  def page_params
    params[:page][:hashtag] = Tweet.pound_sign(params[:page][:hashtag]) if params[:page][:hashtag].present?
    params.require(:page).permit!
  end

  def all_pages
    @user_tags = current_user.pages
  end

end 