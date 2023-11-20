module PagesHelper

  def category_illustration_url(category)
    if Rails.env.test?
      asset_url("marketing.jpg")
    else
      category.pending? ? asset_url("#{category.slug}-bw.jpg") : asset_url("#{category.slug}.jpg")
    end
  end

  def render_subcategory_body(category_slug, subcategory_slug)
    if File.exist?("app/views/subcategories/show/#{category_slug}/_#{subcategory_slug}.html.erb")
      content_tag(:p, class: "mb-4") do
        render("subcategories/show/#{category_slug}/#{subcategory_slug}")
      end
    end
  end
end
