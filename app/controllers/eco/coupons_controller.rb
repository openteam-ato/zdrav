class Eco::CouponsController < Eco::ApplicationController

  def index
    @coupons = Eco::CouponsSearcher.new(params).results
  end

  def delete_mi
    coupon = Coupon.find(params[:coupon_id])
    coupon.to_created!

    redirect_to eco_coupon_path(params[:coupon_id])
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_user, 'eco')
  end
end
