module Api
	class UsersController < BaseController
	 	# before_action :set_user, only: [:show]

		def index
			@users = User.all
			render json: @users
		end

		def show
			@user = User.find(params[:id])
			render json: @user
		end

		def blog
			@posts = Post.includes(:user).where(user_id: params[:id]).order(created_at: :desc)
			render json: @posts
		end

		def feed
			@posts = Post.feed_of(params[:id])
			render json: @posts
		end

		def who_am_i
			if doorkeeper_token
				me = User.find(doorkeeper_token.resource_owner_id)
			else
				me = { user: { id: 0, username: "not logged in", first_name: "", last_name: "" } }
			end
			render json: me
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
end