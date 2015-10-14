class CouponsController < MainController

  before_filter :prepare_cms

  def index
  end

  def show
    number = params[:coupon][:number].gsub(/\D+/, '') if params.try(:[], :coupon).try(:[], :number).present?
    @coupon = Coupon.search { with :number, number }.results.first
    if @coupon && @coupon.created?
      coupons = Coupon.search {
        with :workflow_state, :created
        order_by :number
        paginate :page => 1, :per_page => 1_000_000
      }.results
      @coupon_position = coupons.index(@coupon) + 1
    end
  end

end
