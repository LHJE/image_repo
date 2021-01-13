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

  def create
    @image = current_user.images.create(image_params)
    if @image.save
      flash[:notice] = "#{@image.keyword.capitalize} Image Uploaded!"
      redirect_to '/images'
    else
      generate_flash(@image)
      render :new
    end
  end

  private

  def image_params
    params.require(:image).permit(:keyword, :url, :user_id)
  end
end
