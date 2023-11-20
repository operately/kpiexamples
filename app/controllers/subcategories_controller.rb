class SubcategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:category_id])
    @subcategory = @category.subcategories.friendly.find(params[:id])
    @total_count = @subcategory.kpis.count

    @kpis = @subcategory.kpis.includes(:category).order("name ASC").page(params[:page]).per(20)
  end
end
