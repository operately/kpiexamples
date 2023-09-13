class Admin::UsersController < Admin::BaseController
  def index
    @users = User.order("created_at DESC")
  end

  def show
    @user = User.find(params[:id])
    @kpi_upvotes = @user.kpi_upvotes.order("created_at DESC")
  end
end
