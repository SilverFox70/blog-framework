class CommentsController < InheritedResources::Base

	def index
		redirect_to posts_path(action: :index) unless admin_user_signed_in?
		
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		redirect_to post_path(@post)
	end

	def edit
		c = Comment.find_by_id(params[:id])
		!c.nil? ? comment_author = c.user_id : comment_author = nil
		if current_user && current_user.id == comment_author
			@comment = Comment.find(params[:id])
      render "edit"
		else
			redirect_to "/users/sign_in"
		end
	end

	def show
		@comment = Comment.find(params[:id])
		@post = Post.find(@comment.post_id)
		redirect_to post_path(@post.id)
	end

	def destroy
		c = Comment.find_by_id(params[:id])
		post_id = c.post_id
		!c.nil? ? comment_author = c.user_id : comment_author = nil
		if current_user && current_user.id == comment_author
			c.destroy
		end
		@post = Post.find(post_id)
		@comments = @post.comments.all
    respond_to do |format|
      format.html {redirect_to post_path(post_id)}
      format.json {render json: {:comment_number => params[:id]}}
    end
	end

  private

    def comment_params
      params.require(:comment).permit(:author, :body, :post_id, :user_id)
    end
end

