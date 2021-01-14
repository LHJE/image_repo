class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.reverse
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @posts = Post.where(id: params[:id])[0]
  end

  # GET /posts/new
  def new
    if !current_user
      flash[:notice] = 'This Page Only Accessible by Authenticated Users. Please Log In.'
      redirect_to '/posts'
    else
      @post = Post.new
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    return unless !current_user || current_user.id != @post.user_id

    flash[:notice] = 'You are not authorized to update this post!'
    redirect_to "/posts"
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.create(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :keyword, :user_id, :image)
    end
end