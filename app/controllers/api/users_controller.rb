module Api
	class UsersController < BaseController
	 	# before_action :set_user, only: [:show]

		def index
			@users = User.all
			render json: @users
		end

		def show
			if params[:id] == "me"
				who_am_i
			else
				@user = User.find(params[:id])
				render json: @user
			end
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
			# if doorkeeper_token.nil? 
			# 	raise "doorkeeper_token is nil"
			# end
			# raise doorkeeper_token.to_yaml
			if doorkeeper_token
				# me = { user: { id: 1, username: "Logged in", first_name: "", last_name: "" } }
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