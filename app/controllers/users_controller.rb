class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :blog, :feed]
  before_action :check_if_logged_in, only: [:edit, :update, :destroy]
  before_action :check_if_modifying_yourself, only: [:edit, :update, :destroy]


  # GET /users
  def index
    @users = User.all
    @friend_ids = current_user.friends.pluck(:id) if (!current_user.nil?)
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    render :edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to welcome_index_path, notice: 'Thank you for signing up!'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    reset_session
    redirect_to root_url, notice: 'Your user account was deleted. You aren\'t registered here anymore.'
  end

  # GET /users/1/blog
  # displays all posts by the specified user
  def blog
    @posts = Post.includes(:user).where(user_id: params[:id]).order(created_at: :desc)
  end

  # GET /users/1/feed
  # displays all posts by the friends of the specified user
  def feed
    friend_ids = Friendship.where(user_id: params[:id]).pluck(:friend_id)
    @posts = Post.includes(:user).where(user_id: friend_ids).order(created_at: :desc)
  end

  # GET /users/1/follow
  # adds the specified user to the list of friends of the current user
  def follow
    if (!current_user.friends.exists?(params[:id]))
      fs = Friendship.new(user_id: current_user.id, friend_id: params[:id])
      if fs.save
        redirect_to user_url(params[:id]), notice: "Now you can read this user's posts in your friends feed."
      else
        flash.alert = "Something went wrong. You cannot follow this user."
        redirect_to user_url(params[:id])
      end
    end
  end

  # GET /users/1/unfollow
  # adds the specified user to the list of friends of the current user
  def unfollow
    fs = Friendship.where(user_id: current_user, friend_id: params[:id]).first
    if fs
      fs.destroy
      redirect_to user_url(params[:id]), notice: "This user was removed from your list of friends."
    else
      flash.alert = "Something went wrong. You weren't following that user."
      redirect_to users_url
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation)
    end

    def check_if_logged_in
      if (current_user.nil?)
        flash.alert = "You must be logged in to perform this action."
        redirect_to login_url
      end
    end

    def check_if_modifying_yourself
      if @user.id != current_user.id
        flash.alert = "You only can modify your own account."
        redirect_to user_url(current_user.id)
      end
    end

end
