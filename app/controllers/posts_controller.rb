class PostsController < InheritedResources::Base
    before_action :category_list, only: [:index, :show]
    before_action :two_columns?, only: [:index, :show]

    def index
      check_offset
      #if we were passed a query_note from a fruitless search, let the user know
      @q_notice = params[:query_note] if !params[:query_note].nil?
      # Set scope of the posts we will look at
      @search = Post.search(params[:q])
      # If a search was requested, show results, if any, else show 
      # selected category of posts.
      if params[:commit] == "Search"
        @posts = @search.result
        if @posts.count == 1
            redirect_to post_path(@posts.first.id)
        elsif @posts.count == 0
            query_notice = "We're sorry, but no posts matched your search query."
            set_posts_scope(params[:category])
            redirect_to posts_path(:commit => "None", query_note: "#{query_notice}")
        end
      else
        set_posts_scope(params[:category])
        params[:category].nil? ? @selected_category = "none" : @selected_category = params[:category]
      end
      # if no start params given, then return the 3 most
      # recent posts; otherwise, get the most recent posts
      # offset by :offset e.g. @offset = -3, get the fourth
      # fifth, and sixth most recent posts. :offset must 
      # track through each call.
      if @offset == 0
        @posts = get_most_recent_posts
      else @offset = params[:offset].to_i 
        # if @offset is less than 1, set @offset = 1
        # or if @offset is greater than the last Post.id
        # value, set it equal to the last Post.id
        # if @offset < 1
        #     @offset = 1
        #     stop = @offset + 2
        # elsif @offset >= get_upper_limit
        #     @offset = get_upper_limit
        #     @limit = true
        # end
        # stop = @offset + 2
        @posts = get_posts_from(@offset)
      end
      set_limits
    end

    def edit
      if admin_user_signed_in?
        @post = Post.find_by_id(params[:id])
        render "edit"
      else
        redirect_to "index"
      end
    end

    def show
      @search = Post.search(params[:q])
      if params[:commit] == "Search"
        @posts = @search.result
        render action: "index"
      end
      @post = Post.find(params[:id])
      @comments = @post.comments.all
    end

  private

    def two_columns?
      @columns = (@categories.length > 3)
      @columns ? @split_at = column_size(@categories.length) : @split_at = 3
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
        @scoped_posts = Post.all
      else
        @scoped_posts = Post.where(:category => category)
      end
      @posts
    end

    def category_list
      @categories = []
      posts = Post.all
      posts.each do |post|
        if !@categories.include?(post.category)
          @categories << post.category
        end
      end
      @categories
    end

    def check_offset
      if params[:offset].nil?
        @offset = 0
      else
        @offset = params[:offset].to_i
      end
      @offset = 0 if @offset < 0
    end

    def set_limits
      @up_limit = check_up_limit
      @low_limit = check_low_limit
    end

    # Because the grouping of @posts is in reverse order, we check
    # the id of the "first" in the group, which is really the record
    # with the highest id
    def check_up_limit
      @posts.first.id == @scoped_posts.last.id   
    end

    def check_low_limit
      @posts.last.id == @scoped_posts.first.id
    end

    def get_most_recent_posts
      @scoped_posts.order("id desc").limit(3)
    end

    def get_posts_from(start)
      these_posts = @scoped_posts.order("id desc").limit(3).offset(start)
      these_posts
    end

    def post_params
      params.require(:post).permit(:title, :date, :content, :category, :img_url)
    end
end

