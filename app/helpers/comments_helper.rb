module CommentsHelper

  def comment_apply_style(content)
    sanitized_content = sanitize(content, tags: %w(strong em a p ul li ol), attributes: %w(href))

    doc = Nokogiri::HTML.fragment(sanitized_content)

    # Find and modify all links
    doc.css('a').each do |link|
      link['target'] = '_blank'
      link['rel'] = 'nofollow'
      link['class'] = 'text-operately-blue hover:text-operately-dark-blue underline'
      link.inner_html += '<svg style="display: inline; margin-left: 4px;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-external-link"><path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path><polyline points="15 3 21 3 21 9"></polyline><line x1="10" y1="14" x2="21" y2="3"></line></svg>'
    end

    # Style unordered lists
    doc.css('ul').each do |ul|
      ul['class'] = 'mt-4 mb-4 pl-5 list-disc list-inside'
    end

    # Style ordered lists
    doc.css('ol').each do |ol|
      ol['class'] = 'mt-4 mb-4 pl-5 list-decimal list-inside'
    end

    # Style list items
    doc.css('li').each do |li|
      li['class'] = 'mb-2'
    end

    # Style paragraphs
    doc.css('p').each do |li|
      li['class'] = 'mb-4'
    end

    doc.to_html.html_safe
  end

end
