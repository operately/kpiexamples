class Kpi < ApplicationRecord
  belongs_to :category

  VALID_UNITS = ['money', 'percentage', 'time', 'number'].freeze

  validates :unit, inclusion: { in: VALID_UNITS, message: "%{value} is not a valid unit" }
  validates :description, presence: true
end
