class Sheet

  ROW_KPIS = 2
  ROW_CATEGORIES = 3

  def initialize(row)
    @session = GoogleDrive::Session.from_config("google_drive_config.json")

    @spreadsheet = @session.spreadsheet_by_title("KPI Examples Data")

    @worksheet = @spreadsheet.worksheets[row]
  end

  def rows
    @rows ||= @worksheet.rows.drop(1).reject { |r| r[0].blank? }
  end
end
