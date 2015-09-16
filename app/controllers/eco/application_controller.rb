class Eco::ApplicationController < ApplicationController
  layout 'manage'

  before_filter :redirect_access
  sso_load_and_authorize_resource

  actions :all, :except => [:update]

  private

  def redirect_access
    redirect_to manage_root_path if current_user && current_user.manager?
  end
end
