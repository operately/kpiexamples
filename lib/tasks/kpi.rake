namespace :kpi do
  desc "Sync categories and KPIs with Google Sheet"
  task sync: :environment do
    Rails.logger = Logger.new(STDOUT)
    Category.sync_with_google_sheet
    Kpi.sync_with_google_sheet
  end

  desc "Mark categories with KPIs as pending=false"
  task activate_categories: :environment do
    Rails.logger = Logger.new(STDOUT)
    Category.find_each do |category|
      if category.kpis.any?
        Rails.logger.info "Category #{category.name} is live"
        category.pending = false
        category.save!
      end
    end
  end
end
