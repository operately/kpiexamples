class KpisController < ApplicationController
  def show
    @category = Category.friendly.find(params[:category_id])
    @kpi = @category.kpis.friendly.find(params[:id])
  end
end
