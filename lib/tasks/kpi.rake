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

  # Run with paremeters like this:
  #   INCLUDE_KPIS=true CATEGORY_NAME='Category Name' rails kpi:print_hierarchy
  desc "Prints a hierarchy of all categories or a single category, its subcategories, and optionally KPIs"
  task :print_hierarchy => :environment do
    include_kpis = ENV['INCLUDE_KPIS'] == 'true'
    category_name = ENV['CATEGORY_NAME']

    categories = category_name ? Category.where(name: category_name) : Category.all

    categories.find_each do |category|
      puts category.name
      category.subcategories.find_each do |subcategory|
        puts "  #{subcategory.name}"
        if include_kpis
          subcategory.kpis.find_each do |kpi|
            puts "    #{kpi.name}"
          end
        end
      end
    end
  end
end
