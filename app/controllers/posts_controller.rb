class PostsController < ApplicationController
  before_action :check_logged_in, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to blog_path(current_user), notice: 'The post was created!'
    else
      render :new
    end
    # respond_with @post
  end

  def edit
    render :edit
  end

  def update
    if @post.update(post_params)
      redirect_to blog_path(id: current_user.id, anchor: 'post'+@post.id.to_s)
    else
      render :edit
    end
 end

  def show
    @postuser = User.where(id: @post.user_id).pluck(:username).first
    @postbody = @post.body
  end

  def destroy
    if @post.user_id == current_user.id
      @post.destroy
      redirect_to blog_path, notice: 'The post was deleted'
    else
      redirect_to blog_path, notice: 'You are not allowed to edit other users\' posts.'
    end

  end

  private

  def check_logged_in
    if current_user.nil? 
      flash.alert = "You must be logged in to add or edit posts."
      redirect_to login_url
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :bootsy_image_gallery_id)
  end
end
