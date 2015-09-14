class Eco::CouponsController < Eco::ApplicationController

  def index
    @coupons = Eco::CouponsSearcher.new(params).results
  end

  def update
    update!{
      @coupon.send("to_#{params[:state]}!") if @coupon.aasm.events.map(&:name).include? "to_#{params[:state]}".to_sym
      redirect_to [:eco, @coupon] and return
    }
  end

  def revert_state
    coupon = Coupon.find(params[:coupon_id])
    coupon.rollback!
    redirect_to [:eco, coupon]
  end

  private

  def current_ability
    @current_ability ||= Ability.new(current_user, 'eco')
  end
end
