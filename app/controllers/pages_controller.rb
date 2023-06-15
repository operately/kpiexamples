class PagesController < ApplicationController
  def home
    @categories = Category.all.order("name ASC")
  end
end
