class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true

  validates :content, presence: true
  validates :user_id, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true

  scope :top_level, -> { where(parent_id: nil) }

  def reply?
    parent_id.present?
  end

  def written_by?(specific_user)
    user == specific_user
  end

  def was_updated?
    created_at != updated_at
  end
end
