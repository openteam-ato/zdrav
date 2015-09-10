class Eco::CouponsController < Eco::ApplicationController

  private

  def current_ability
    @current_ability ||= Ability.new(current_user, 'eco')
  end
end
