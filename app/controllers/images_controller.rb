class ImagesController < ApplicationController
  def index; end

  def new
    if !current_user
      flash[:notice] = 'This Page Only Accessible by Authenticated Users. Please Log In.'
      redirect_to '/images'
    else
      @image = Image.new
    end
  end
end
