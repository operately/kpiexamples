class KpisController < ApplicationController

  before_action :find_category_and_kpi, except: [:search]
  before_action :require_login, only: [:upvote, :downvote]

  def show
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

  def upvote
    current_user.upvoted_kpis << @kpi unless current_user.upvoted_kpis.include?(@kpi)
    dom_id = params[:dom_id]

    respond_to_voting_turbo_stream
  end

  def downvote
    current_user.upvoted_kpis.delete(@kpi)
    dom_id = params[:dom_id]

    respond_to_voting_turbo_stream
  end

  protected

  def find_category_and_kpi
    @category = Category.friendly.find(params[:category_id])
    @kpi = @category.kpis.friendly.find(params[:id])
  end

  def respond_to_voting_turbo_stream
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(params[:dom_id], partial: 'kpis/votes')
      end
    end
  end
end
