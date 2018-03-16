module Admin
  class BaseController < ApplicationController
    before_action :admin_user

    def admin_user
      redirect_to root_url unless current_user.present? && current_user.admin?
    end
  end
end
