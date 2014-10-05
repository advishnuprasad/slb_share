class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :favorite, :unfavorite]
  before_filter :authenticate_user!, :only => [:new, :create, :update, :destroy, :favorite, :unfavorite, :favorites]
  # GET /posts
  # GET /posts.json
  def index
    @page_title = "Links"
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).paginate(:page => params[:page])
    else
      @posts = Post.all.order("created_at desc").paginate(:page => params[:page])
    end
  end

  def by_year_and_month
    @posts = Post.where("EXTRACT(YEAR FROM created_at)= ? AND EXTRACT(MONTH from created_at) = ? ", params[:year], params[:month]).order("created_at DESC").paginate(:page => params[:page])
    render :index
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  def user
    user = User.find(params[:user_id])
    @posts = user.posts.paginate(:page => params[:page])
    render :index
  end
  # GET /posts/new
  def new
    @page_title = "New Link"
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
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
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def search
    @posts = Post.search(params)
    render :index
  end

  def favorite
    current_user.set_mark :favorite, @post
    respond_to do |format|
      format.js
    end
  end

  def unfavorite
    current_user.remove_mark :favorite, @post
    respond_to do |format|
      format.js
    end
  end

  def favorites
    @posts = current_user.favorite_posts.paginate(:page => params[:page])
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :links, :tags, :user_id, :tag_list => [])
    end
end
