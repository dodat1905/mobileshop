class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit :name, :address, :email,
      :password, :password_confirmation, :phone
  end

  def account_update_params
    params.require(:user).permit :name, :address, :email, :password,
      :password_confirmation, :phone, :current_password
  end
end
