class Subcategory < ApplicationRecord
  validates :name, presence: true

  belongs_to :category
  has_many :kpis

  extend FriendlyId
  friendly_id :name, use: :slugged

  # regenerate the slug when the name changes
  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
