class Sheet

  def initialize
    @session = GoogleDrive::Session.from_config("google_drive_config.json")

    @spreadsheet = @session.spreadsheet_by_title("KPI Examples Data")

    @worksheet = @spreadsheet.worksheets.third
  end

  def rows
    @rows ||= @worksheet.rows.drop(1)
  end
end
