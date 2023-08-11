class Category < ApplicationRecord
  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :subcategories, dependent: :destroy
  has_many :kpis
end
