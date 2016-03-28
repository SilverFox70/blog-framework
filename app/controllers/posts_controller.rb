class PostsController < InheritedResources::Base

  private

    def post_params
      params.require(:post).permit(:title, :date, :content, :category)
    end
end

