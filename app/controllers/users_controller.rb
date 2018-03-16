class UsersController < ApplicationController
  attr_reader :user

  before_action :find_user, only: %i(edit show destroy)

  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @orders = user.orders.desc.paginate page: params[:page]
  end

  def edit; end

  private

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    flash[:success] = t "failed_user"
    redirect_to root_path
  end
end
