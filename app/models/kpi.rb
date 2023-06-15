class Kpi < ApplicationRecord
  belongs_to :category

  VALID_UNITS = ['money', 'percentage', 'time', 'number'].freeze

  validates :unit, inclusion: { in: VALID_UNITS, message: "%{value} is not a valid unit" }
  validates :description, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  def self.sync_with_google_sheet
    Rails.logger.info "[KPI sync] start"

    sheet = Sheet.new
    categories = Category.all.to_a

    sheet.rows.each do |row|
      category = find_or_create_category(row, categories)
      update_or_create_kpi(row, category)
    end

    Rails.logger.info "[KPI sync] complete"
  end

  protected

  def self.find_or_create_category(row, categories)
    category = categories.find {|c| c.name == row[1] }
    return category unless category.nil?

    category = Category.create!(name: row[1])
    Rails.logger.info "[KPI sync] Created a new category: #{category.name}"
    categories << category
    category
  end

  def self.update_or_create_kpi(row, category)
    kpi = Kpi.find_or_initialize_by(name: row[0], category: category)
    kpi.unit = row[3].downcase
    kpi.description = row[4]
    kpi.formula = row[5]
    kpi.example = row[6]

    if kpi.new_record?
      Rails.logger.info "[KPI sync] Creating a new KPI: #{kpi.name} in #{kpi.category.name}"
      kpi.save!
    elsif kpi.changed?
      Rails.logger.info "[KPI sync] Updating #{kpi.name} in #{kpi.category.name}"
      kpi.save!
    else
      Rails.logger.info "[KPI sync] Nothing changed about #{kpi.name} in #{kpi.category.name}"
    end
  end

end
