class Eco::CouponsController < Eco::ApplicationController

  def index
    @coupons = Eco::CouponsSearcher.new(params).results
  end

  def revert_state
    coupon = Coupon.find(params[:coupon_id])
    if coupon.current_state.events.keys.include?("to_#{params[:state]}".to_sym)
      coupon.touch_with_version
      coupon.send("to_#{params[:state]}!")
    end
    redirect_to eco_coupon_path(coupon)
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_user, 'eco')
  end
end
