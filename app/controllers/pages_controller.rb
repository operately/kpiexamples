class PagesController < ApplicationController
  def home
    @categories = Category.all.order("name ASC")
  end

  def sitemap
    @host = request.protocol + request.host_with_port

    @categories = Category.all.order("name ASC")
    @kpis = Kpi.all.order("name ASC")

    respond_to do |format|
      format.xml
    end
  end

  def sign_in
    session[:return_path] = params[:return_path] if params[:return_path].present?
  end
end
