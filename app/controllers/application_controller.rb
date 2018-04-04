class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include CurrentCart

  before_action :set_locale

  class << self
    def default_url_options
      {locale: I18n.locale}
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def force_json
    request.format = :json
  end

  before_action :current_cart
end
