class Admin::BaseController < ApplicationController

  before_action :check_site_owner

  private
  
  def check_site_owner
    site_owners = ENV['SITE_OWNERS']&.split(',') || []

    unless current_user && site_owners.include?(current_user.email)
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end

