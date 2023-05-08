class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_post_params
  rescue_from ActiveRecord::RecordNotFound, with: :post_not_found

  def show
    post = Post.find(params[:id])

    render json: post
  end

  def update
    post = find_post
    post.update!(post_params)
    render json: post
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  def find_post
    Post.find(params[:id])
  end

  def invalid_post_params(invalid)
    render json: {
             errors: invalid.record.errors
           },
           status: :unprocessable_entity
  end

  def post_not_found
    render json: { error: "Post not found" }, status: :not_found
  end
end
