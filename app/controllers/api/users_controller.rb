module Api
  class UsersController < BaseController
    
    def index
      @users = User.all
      render json: @users
    end
  end
end