module Admin
  class BaseController < ApplicationController
    before_action :admin_user

    def admin_user
      redirect_to root_url unless current_user.try(:admin?)
    end
  end
end
