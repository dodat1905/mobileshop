class NotificationsController < ApplicationController
  attr_reader :unread

  before_action :force_json
  before_action :unread_message

  def index
    @notifications = Notification.desc.all
  end

  # rubocop:disable Rails/SkipsModelValidations

  def update
    unread.update_all read_at: Time.zone.now
    render json: {success: true}
  end

  # rubocop:enable Rails/SkipsModelValidations

  private

  def unread_message
    @unread = Notification.unread_notification
  end
end
