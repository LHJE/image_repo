class ImagesController < ApplicationController
  def index
    @images = Image.all.reverse
  end

  def show
    @image = Image.where(id: params[:id])[0]
  end

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

  def edit
    @image = Image.find(params[:id])
    if !current_user || current_user.id != @image.user_id
      flash[:notice] = 'You are not authorized to update this image!'
      redirect_to "/images/#{@image.id}"
    end
  end

  def update
    @image = Image.find(params[:id])
    if @image.update(image_params)
      flash[:notice] = "Image Updated!"
      redirect_to "/images/#{@image.id}"
    else
      generate_flash(@image)
      render :edit
    end
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    flash[:notice] = 'Image Deleted!'
    redirect_to '/images'
  end

  private

  def image_params
    params.require(:image).permit(:keyword, :url, :user_id)
  end
end
