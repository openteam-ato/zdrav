class Manage::ApplicationController < ApplicationController
  layout 'manage'

  before_filter :redirect_access
  sso_load_and_authorize_resource

  def redirect_access
    redirect_to eco_coupons_path if current_user && current_user.operator?
  end

  private

  def current_ability
    Ability.new(current_user, 'manage')
  end
end
