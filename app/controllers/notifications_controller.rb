class NotificationsController < ApplicationController

  def create
    @notification = Notification.new(notification_params)

  end

end


# does this have to be nested??
