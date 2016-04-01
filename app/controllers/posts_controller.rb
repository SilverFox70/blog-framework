class PostsController < InheritedResources::Base

	def index
		puts "-" * 30
		puts params
		puts "-" * 30
		# if no start params given, then return the 3 most
		# recent posts; otherwise, get the most recent posts
		# offset by :start e.g. start = -3, get the fourth
		# fifth, and sixth most recent posts. :start must 
		# track through each call.
		if params[:start].nil?
			@start = 1
			@posts = Post.order("id asc").limit(3)
		else @start = params[:start].to_i 
			stop = @start + 3
			@posts = Post.where(:id => @start..stop).order("id asc")
		end
	end

  private

    def post_params
      params.require(:post).permit(:title, :date, :content, :category)
    end
end

