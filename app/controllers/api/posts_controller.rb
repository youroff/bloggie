module Api
	class PostsController < BaseController
		before_action :set_post, only: [:show]

		def index
			@posts = Post.all
			render json: @posts
		end

		def show
			render json: @post
		end

		private
			def set_post
			@post = Post.find(params[:id])
		end


	end
end