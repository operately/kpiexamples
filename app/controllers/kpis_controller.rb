class KpisController < ApplicationController
  def show
    @category = Category.friendly.find(params[:category_id])
    @kpi = @category.kpis.friendly.find(params[:id])
    @other_kpis = @kpi.subcategory.kpis.where("id != ?", @kpi.id).order("RANDOM()").limit(5)
  end

  def search
    @query = params[:query]
    scope = Kpi.search_by_content(@query)
    @kpis = scope.page(params[:page]).per(20)

    if params[:autocomplete]
      render partial: "search_autocomplete", layout: false
    else
      @total_count = scope.count
      # render template
    end
  end
end
