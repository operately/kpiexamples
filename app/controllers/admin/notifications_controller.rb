class Admin::NotificationsController < Admin::BaseController
  def index
    @notifications = Notification.all
  end
end
