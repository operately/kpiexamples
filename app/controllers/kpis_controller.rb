class KpisController < ApplicationController
  def show
    @category = Category.friendly.find(params[:category_id])
    @kpi = @category.kpis.friendly.find(params[:id])
  end

  def search
    @kpis = Kpi.search_by_content(params[:query])
    render layout: false
  end
end
