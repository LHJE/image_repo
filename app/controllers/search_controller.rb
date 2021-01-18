class SearchController < ApplicationController
  def index
    @images = Image.where(keyword: params[:keyword].downcase).reverse
  end
end
