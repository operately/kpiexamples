module ApplicationHelper
  def page_title
    @page_title ||= "KPI Examples"
  end

  def set_page_title(title, options = {})
    @page_title = title
    @page_title += " - KPI Examples" unless options[:full].present?
  end

  def substring_until_period(string)
    index = string.index('.')
    index ? string[0...index+1] : string
  end

  def meta_description(content)
    "<meta name=\"description\" content=\"#{content}\">".html_safe
  end
end
