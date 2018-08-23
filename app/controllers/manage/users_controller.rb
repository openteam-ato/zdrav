class Manage::UsersController < Manage::ApplicationController
  def index
    @users = User.ordered.page(params[:page]).per(params[:per_page])
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if @user.update user_params
      redirect_to manage_users_path
    else
      render action: :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :name, permissions_attributes: [:id, :role, :_destroy])
  end
end
