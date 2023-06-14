class Sheet

  def initialize
    @session = GoogleDrive::Session.from_config("google_drive_config.json")

    @spreadsheet = @session.spreadsheet_by_title("KPIs data model draft")

    @worksheet = @spreadsheet.worksheets.first
  end

  def rows
    @rows ||= @worksheet.rows.drop(1)
  end
end
