class CommentsController < ApplicationController
  attr_reader :comment, :product
  before_action :correct_user, only: %i(destroy)
  before_action :find_product, only: %i(create destroy)

  def new; end

  def create
    @comment = product.comments.build comment_params
    comment.user = current_user

    if comment.save
      comment_success
    else
      comment_failed
    end
  end

  def show
    @product = Product.find_by id: params[:id]
    @comments = product.comments.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    comment.destroy
    flash[:success] = t "micropost_deleted"
    redirect_to request.referer || root_url
  end

  private

  def find_product
    @product = Product.find_by id: params[:product_id]
  end

  def comment_params
    params.require(:comment).permit(:description)
  end

  def comment_success
    flash[:success] = t "comment_created"
    redirect_to product
  end

  def comment_failed
    redirect_to product, alert: "Review could not be saved"
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url unless comment
  end
end
