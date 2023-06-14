class KpisController < ApplicationController
  def show
    @kpi = Kpi.find(params[:id])
  end
end
