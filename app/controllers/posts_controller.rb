class PostsController < InheritedResources::Base

	def index
		puts "-" * 30
		puts params
		puts "-" * 30
		start = params[:start] if params{:start} != nil
		@posts = Post.all
	end

  private

    def post_params
      params.require(:post).permit(:title, :date, :content, :category)
    end
end

