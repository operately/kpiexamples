module KpisHelper
  def emoji_for_unit(unit_type)
    case unit_type
    when 'money'
      "💰"
    when 'percentage'
      "%"
    when 'time'
      "⏱"
    when 'number'
      "#"
    else
      ""
    end
  end

  def unit_emoji_tag(unit_type)
    content_tag(:span, title: unit_type.capitalize, "aria-label": unit_type.capitalize) do
      emoji_for_unit(unit_type)
    end
  end
end
