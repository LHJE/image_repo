class ImagesController < ApplicationController
  before_action :set_image, only: %i[show edit update destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all.reverse
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.where(id: params[:id])[0]
  end

  # GET /images/new
  def new
    if !current_user
      flash[:notice] = 'This Page Only Accessible by Authenticated Users. Please Log In.'
      redirect_to '/images'
    else
      @image = Image.new
    end
  end

  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
    return unless !current_user || current_user.id != @image.user_id

    flash[:notice] = 'You are not authorized to update this image!'
    redirect_to '/images'
  end

  # POST /images
  # POST /images.json
  def create
    @image = current_user.images.create(image_params)
    @image.keyword = @image.keyword.downcase
    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def image_params
    params.require(:image).permit(:title, :body, :keyword, :user_id, :image)
  end
end
