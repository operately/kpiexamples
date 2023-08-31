# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def category_confirmation_email
    NotificationMailer.category_confirmation_email(Notification.first)
  end
end
