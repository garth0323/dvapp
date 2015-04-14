class PostsController < ApplicationController

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :back
  end

end