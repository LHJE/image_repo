class SearchController < ApplicationController
  def index
    @posts = Post.where(keyword: params[:keyword]).reverse
  end
end
