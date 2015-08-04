module Api
	class PostsController < BaseController
		before_action :set_post, only: [:show]
    has_scope :kind

		def index
			@posts = apply_scopes(Post).all
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