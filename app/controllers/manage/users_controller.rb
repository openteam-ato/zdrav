class Manage::UsersController < Manage::ApplicationController

  def index
    @users = User.ordered.page(params[:page]).per(params[:per_page])
  end

end
