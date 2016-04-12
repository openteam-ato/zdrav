class Eco::ApplicationController < MainController

  layout 'manage'

  sso_load_and_authorize_resource

  actions :all, :except => [:update]

  private

  def current_ability
    Ability.new(current_user, 'eco')
  end

end
