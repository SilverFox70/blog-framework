class PostsController < InheritedResources::Base

	def index
		puts "-" * 30
		puts params
		puts "-" * 30
		# @limit will be set to true of we are looking
		# at the last available post
		@limit = false
		# if no start params given, then return the 3 most
		# recent posts; otherwise, get the most recent posts
		# offset by :start e.g. start = -3, get the fourth
		# fifth, and sixth most recent posts. :start must 
		# track through each call.
		if params[:start].nil?
			@start = Post.order(:id).last.id - 2
			stop = @start + 3
			@posts = Post.where(:id => @start..stop).order("id desc")
			@limit = true
		else @start = params[:start].to_i 
			# if @start is less than 1, set @start = 1
			# or if @start is greater than the last Post.id
			# value, set it equal to the last Post.id
			if @start < 1
				@start = 1
				stop = @start + 2
			elsif @start > (Post.order(:id).last.id - 2)
				@start = Post.order(:id).last.id - 2
				@limit = true
			end
			stop = @start + 2
			@posts = Post.where(:id => @start..stop).order("id desc")
		end
	end

  private

    def post_params
      params.require(:post).permit(:title, :date, :content, :category)
    end
end

