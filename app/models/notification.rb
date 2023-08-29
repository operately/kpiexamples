class Notification < ApplicationRecord
  belongs_to :category

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: { scope: :category_id, message: "has already been registered for notifications for this category" }
end
