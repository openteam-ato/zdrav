class Eco::CouponsController < Eco::ApplicationController

  def index
    @coupons = Eco::CouponsSearcher.new(params).results
  end

  def update
    @coupon = Coupon.find(params[:id])
    @coupon.assign_attributes(params[:coupon]) # установка значений без save

    @coupon.send("to_#{params[:state]}") if @coupon.aasm.events.map(&:name).include? "to_#{params[:state]}".to_sym

    if @coupon.save
      redirect_to [:eco, @coupon]
    else
      render 'edit'
    end
  end

  def show
    show! {
      add_breadcrumb "Список талонов", eco_coupons_path
      add_breadcrumb "Талон №#{@coupon.number}", eco_coupon_path(@coupon)
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
