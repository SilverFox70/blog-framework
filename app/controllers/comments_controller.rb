class CommentsController < InheritedResources::Base

	def index
		redirect_to post_path unless admin_user_signed_in?
		
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		redirect_to post_path(@post)
	end

	def edit
		@comment = Comment.find(params[:id])
	end

  private

    def comment_params
      params.require(:comment).permit(:author, :body, :post_id, :user_id)
    end
end

