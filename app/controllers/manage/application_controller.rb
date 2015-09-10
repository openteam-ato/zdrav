class Manage::ApplicationController < ApplicationController
  before_filter :redirect_access

  sso_load_and_authorize_resource

  layout 'manage'

  def redirect_access
    redirect_to eco_eco_coupons_path if current_user.operator?
  end

  private

  def current_ability
    Ability.new(current_user, 'manage')
  end
end
