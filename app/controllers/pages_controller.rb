class PagesController < ApplicationController
  def home
    @categories = Category.all.order("name ASC")
  end

  def sitemap
    @host = request.host_with_port

    @categories = Category.all.order("name ASC")
    @kpis = Kpi.all.order("name ASC")

    respond_to do |format|
      format.xml
    end
  end
end
