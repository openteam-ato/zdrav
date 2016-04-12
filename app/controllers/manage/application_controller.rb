class Manage::ApplicationController < MainController
  layout 'manage'

  sso_load_and_authorize_resource

  private

  def current_ability
    Ability.new(current_user, 'manage')
  end
end
