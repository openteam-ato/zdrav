class Eco::CouponsController < Eco::ApplicationController

  def index
    @coupons = Eco::CouponsSearcher.new(params).results
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_user, 'eco')
  end
end
