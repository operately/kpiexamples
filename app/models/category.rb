class Category < ApplicationRecord
  validates :name, presence: true
  validates :summary, length: { maximum: 280 }, allow_blank: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :subcategories, dependent: :destroy
  has_many :kpis

  # regenerate the slug when the name changes
  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def self.sync_with_google_sheet
    Rails.logger.info "[Category sync] start"

    sheet = Sheet.new(Sheet::ROW_CATEGORIES)
    categories = Category.all.to_a

    sheet.rows.each do |row|
      Rails.logger.info "[Category sync] Processing #{row[0]}"
      category = Category.find_by(name: row[0])
      if category.nil?
        Rails.logger.info "[Category sync] Creating a new category: #{row[0]}"
        category = Category.create!(name: row[0])
      end

      category.summary = row[1]

      if category.changed?
        Rails.logger.info "[Category sync] Updating #{category.name} summary"
        category.save!
      end
    end

    Rails.logger.info "[Category sync] complete"
  end

end
