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
end
