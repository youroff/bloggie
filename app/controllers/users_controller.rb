class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
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
    if (!current_user.nil?) && (current_user.id == @user.id)
      render :edit
    else
      redirect_to root_url, notice: 'You are not allowed to edit other users.'
    end

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
    if (!current_user.nil?) && (current_user.id == @user.id)
      if @user.update(user_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to root_url, notice: 'You are not allowed to edit other users.'
    end
  end

  # DELETE /users/1
  def destroy
    if @user.id == current_user.id
      @user.destroy
      reset_session
      redirect_to root_url, notice: 'Your user account was deleted. You aren\'t registered here anymore.'
    else
      redirect_to root_url, notice: 'You are not allowed to edit other users.'
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
end
