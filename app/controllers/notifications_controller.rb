class NotificationsController < ApplicationController

  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      redirect_to category_path(@notification.category),
        notice: 'Thank you for your interest! You will be notified when KPIs are added to this category.'
    else
      @category = @notification.category
      @total_count = 0
      render 'categories/show', status: :unprocessable_entity
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:email, :category_id)
  end
end
