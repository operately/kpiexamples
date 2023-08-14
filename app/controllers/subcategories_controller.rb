class SubcategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:category_id])
    @subcategory = @category.subcategories.friendly.find(params[:id])

    @kpis = @subcategory.kpis.order("name ASC").page(params[:page]).per(20)
  end
end
