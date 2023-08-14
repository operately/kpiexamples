class Category < ApplicationRecord
  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :subcategories, dependent: :destroy
  has_many :kpis

  # regenerate the slug when the name changes
  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
