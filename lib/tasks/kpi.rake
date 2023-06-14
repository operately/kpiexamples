namespace :kpi do
  desc "Sync KPIs with Google Sheet"
  task sync: :environment do
    Rails.logger = Logger.new(STDOUT)
    Kpi.sync_with_google_sheet
  end
end
