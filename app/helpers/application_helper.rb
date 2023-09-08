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

  def abbreviated_name(full_name)
    parts = full_name.split
    return full_name if parts.length == 1

    first_name = parts.first
    initials = parts[1..-1].map { |name| "#{name[0]}." }.join
    "#{first_name} #{initials}"
  end
end
