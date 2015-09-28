class Eco::CouponsSearcher
  attr_accessor :params, :page

  def initialize(params = {})
    @params = params
    @page   = params[:page] || 1
  end

  def per_page
    params[:per_page] || 20
  end

  def results
    search = Coupon.search do

      keywords params[:search], :fields => [:number, :patient_code] if params[:search].present?

      %w(number patient_code workflow_state).map(&:to_sym).each do |field|
        with field, params[field] if params[field].present?
      end

      order_by :number

      paginate :page => page, :per_page => per_page
    end

    search.results
  end
end
