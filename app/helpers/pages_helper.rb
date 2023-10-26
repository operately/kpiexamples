module PagesHelper

  def category_illustration_url(category)
    if Rails.env.test?
      asset_url("marketing.jpg")
    else
      category.kpis.any? ? asset_url("#{category.slug}.jpg") : asset_url("#{category.slug}-bw.jpg")
    end
  end

  def render_subcategory_body(category_slug, subcategory_slug)
    if File.exist?("app/views/subcategories/show/#{category_slug}/_#{subcategory_slug}.html.erb")
      render("subcategories/show/#{category_slug}/#{subcategory_slug}")
    else
      Rails.logger.info "file not found: app/views/subcategories/show/#{category_slug}/#{subcategory_slug}.html.erb"
    end
  end
end
