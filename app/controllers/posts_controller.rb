class PostsController < InheritedResources::Base

	def index
		puts "** " * 20
		puts params
		puts "** " * 20
		@categories = category_list
		@columns = two_columns?(@categories.length)
		@columns ? @split_at = column_size(@categories.length) : @split_at = 3
		# @limit will be set to true of we are looking
		# at the last available post
		@limit = false
		# Set scope of the posts we will look at
		set_posts_scope(params[:category])
		# if no start params given, then return the 3 most
		# recent posts; otherwise, get the most recent posts
		# offset by :start e.g. start = -3, get the fourth
		# fifth, and sixth most recent posts. :start must 
		# track through each call.
		if params[:start].nil?
			@start = get_upper_limit
			stop = @start + 2
			@posts = get_posts_from(@start, stop)
			@limit = true
		else @start = params[:start].to_i 
			# if @start is less than 1, set @start = 1
			# or if @start is greater than the last Post.id
			# value, set it equal to the last Post.id
			if @start < 1
				@start = 1
				stop = @start + 2
			elsif @start >= get_upper_limit
				@start = get_upper_limit
				@limit = true
			end
			stop = @start + 2
			@posts = get_posts_from(@start, stop)
		end
	end

  private

  	def two_columns?(number_of_cats)
  		number_of_cats > 3
  	end

  	def column_size(number_of_cats)
  		split_point = 3
  		if number_of_cats > 7
  			number_of_cats % 2 != 0 ? split_point = number_of_cats / 2 : split_point = (number_of_cats / 2) + 1
  		end
  		split_point
  	end

  	def set_posts_scope(category)
  		if category.nil? || category == "All"
  			@posts = Post.all
  		else
  			@posts = Post.where(:category => category)
  		end
  		@posts
  	end

  	def category_list
  		cat_list = []
  		posts = Post.all
  		posts.each do |post|
  			if !cat_list.include?(post.category)
  				cat_list << post.category
  			end
	  	end
	  	cat_list
  	end

  	def get_upper_limit
  		@posts.order(:id).last.id - 2
  	end

  	def get_posts_from(start, stop)
  		@posts.where(:id => start..stop).order("id desc")
  	end

    def post_params
      params.require(:post).permit(:title, :date, :content, :category)
    end
end

