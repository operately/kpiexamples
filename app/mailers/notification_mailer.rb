class NotificationMailer < ApplicationMailer
  default from: 'Operately <notifications@operately.com>',
    to: 'hello@operately.com'

  def category_confirmation_email(notification)
    @notification = notification
    mail(to: @notification.email, subject: "[KPI Examples] You have subscribed for an update on #{@notification.category.name} KPIs")
  end
end
