module ApplicationHelper
  def page_title
    @page_title ||= "KPI Examples"
  end

  def set_page_title(title, options = {})
    @page_title = title
    @page_title += " - KPI Examples" unless options[:full].present?
  end
end
