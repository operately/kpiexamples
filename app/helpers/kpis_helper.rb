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
    when 'score'
      "🏅"
    when 'ratio'
      "⚖️"
    else
      ""
    end
  end

  def unit_emoji_tag(unit_type)
    content_tag(:span, title: unit_type.capitalize, "aria-label": unit_type.capitalize) do
      emoji_for_unit(unit_type)
    end
  end

  def kpi_upvote_count(kpi)
    count = kpi.kpi_upvotes.count
    count > 0 ? content_tag(:span, count, class: "ml-2") : ""
  end

  def to_nearest_five_or_zero(number)
    return number if number <= 10

    modulo = number % 10

    case modulo
    when 0
      number.to_s
    when 1..5
      "#{number - modulo}+"
    else
      "#{number - modulo + 5}+"
    end
  end
end
