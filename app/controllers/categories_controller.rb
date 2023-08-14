class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @subcategories = @category.subcategories
    @kpis = @category.kpis.order("name ASC")
  end
end
