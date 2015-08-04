module Api
	class PostsController < BaseController
		before_action :set_post, only: [:show]

		def index
			case params[:type]
			when "my_blog"
					my_blog
			when "my_feed"
					my_feed 
			else
				@posts = Post.all
				render json: @posts
			end
		end

		def show
			render json: @post
		end

		def my_blog
			posts = Post.where(user_id: current_user.id).order(created_at: :desc)
			render json: posts, root: "posts"
		end

		def my_feed
			posts = Post.feed_of(current_user.id)
			render json: posts, root: "posts"
		end


		private
			def set_post
			@post = Post.find(params[:id])
		end


	end
end