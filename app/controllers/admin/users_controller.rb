module Admin
  class UsersController < Admin::BaseController
    attr_reader :user

    before_action :find_user, only: %i(show edit update destroy)

    def index
      @users = User.desc.paginate page: params[:page], per_page: 10
    end

    def show; end

    def edit; end

    def update
      if user.update_attributes user_params
        flash[:success] = t "user_updated"
        redirect_to admin_users_url
      else
        render :edit
      end
    end

    def destroy
      user.destroy
      flash[:success] = t "user_deleted"
      redirect_to request.referer || root_url
    end

    private

    def user_params
      params.require(:user).permit :name, :address, :phone, :email
    end

    def find_user
      @user = User.find_by id: params[:id]

      return if user
      flash[:success] = t "failed_user"
      redirect_to root_path
    end
  end
end
