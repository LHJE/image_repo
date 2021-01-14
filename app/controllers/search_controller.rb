class SearchController < ApplicationController
  def index
    @images = Image.where(keyword: params[:keyword]).reverse
  end
end
