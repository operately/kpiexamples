class Kpi < ApplicationRecord
  belongs_to :subcategory
  belongs_to :category

  has_many :kpi_upvotes
  has_many :upvoters, through: :upvotes, source: :user

  VALID_UNITS = ['money', 'percentage', 'time', 'number', 'score', 'ratio', 'list'].freeze

  validates :unit, inclusion: { in: VALID_UNITS, message: "%{value} is not a valid unit" }
  validates :description, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  include PgSearch::Model
  pg_search_scope :search_by_content, against: [:name, :description, :example]

  def self.sync_with_google_sheet
    Rails.logger.info "[KPI sync] start"

    sheet = Sheet.new(Sheet::ROW_KPIS)
    categories = Category.all.to_a

    sheet.rows.each do |row|
      category = find_or_create_category(row, categories)
      subcategory = find_or_create_subcategory(row, category)
      update_or_create_kpi(row, category, subcategory)
    end

    Rails.logger.info "[KPI sync] complete"
  end

  # regenerate the slug when the name changes
  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def upvote_by!(user)
    Kpi.transaction do
      KpiUpvote.create!(kpi: self, user: user) unless user.upvoted_kpis.include?(self)
      increment!(:upvote_count)
    end
  end

  def downvote_by!(user)
    Kpi.transaction do
      user.upvoted_kpis.delete(self)
      decrement!(:upvote_count)
    end
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

  def self.find_or_create_subcategory(row, category)
    subcategory = Subcategory.find_or_initialize_by(name: row[2], category: category)

    if subcategory.new_record?
      Rails.logger.info "[KPI sync] Creating a new subcategory: #{subcategory.name} in #{category.name}"
      subcategory.save!
    end

    subcategory
  end

  def self.update_or_create_kpi(row, category, subcategory)
    kpi = Kpi.find_or_initialize_by(name: row[0], category: category)
    kpi.subcategory = subcategory
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
    end

    kpi
  end

end
