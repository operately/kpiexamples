module PagesHelper

  def category_illustration_url(category)
    if Rails.env.test?
      asset_url("marketing.jpg")
    else
      category.kpis.any? ? asset_url("#{category.slug}.jpg") : asset_url("#{category.slug}-bw.jpg")
    end
  end
end
