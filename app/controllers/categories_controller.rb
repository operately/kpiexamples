class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @kpis = @category.kpis.order("name ASC")
  end
end
