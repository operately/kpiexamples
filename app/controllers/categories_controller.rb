class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @subcategories = @category.subcategories.order("name ASC")
    @total_count = @category.kpis.count

    @kpis = @category.kpis.order("name ASC").page(params[:page]).per(20)
  end
end
