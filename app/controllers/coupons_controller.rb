class CouponsController < MainController

  before_filter :prepare_cms

  def index
  end

  def show
    number = params[:coupon][:number].gsub(/\D+/, '') if params.try(:[], :coupon).try(:[], :number).present?
    @coupon = Coupon.search { with :number, number }.results.first

    @coupon
  end

end
