xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  # Static pages
  xml.url do
    xml.loc @host + about_path
    xml.priority 0.5
  end

  xml.url do
    xml.loc @host + contribute_path
    xml.priority 0.5
  end

  @categories.each do |category|
    xml.url do
      xml.loc @host + category_path(category)
      xml.lastmod category.updated_at.strftime('%Y-%m-%d')
      xml.priority 0.9
    end

    category.subcategories.each do |subcategory|
      xml.url do
        xml.loc @host + category_subcategory_path(category, subcategory)
        xml.lastmod subcategory.updated_at.strftime('%Y-%m-%d')
        xml.priority 0.7
      end
    end
  end

  @kpis.each do |kpi|
    xml.url do
      xml.loc @host + category_kpi_path(kpi.category, kpi)
      xml.lastmod kpi.updated_at.strftime('%Y-%m-%d')
      xml.priority 0.8
    end
  end
end
