class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @subcategories = @category.subcategories.order("name ASC")
    @total_count = @category.kpis.count

    @kpis = @category.kpis.order("name ASC").includes(:category)
    @popular_kpis = @category.kpis.order("upvote_count DESC NULLS LAST").includes(:category).limit(5)

    @render_rich_page = File.exist?("app/views/categories/show/bodies/_#{@category.slug}.html.erb")

    if @total_count == 0
      @notification = Notification.new
    end
  end
end
