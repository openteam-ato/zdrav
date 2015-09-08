class EcoCouponsSearcher
  attr_accessor :params, :page

  def initialize(params)
    @params = params || {}
    @page   = params[:page] || 1
  end

  def per_page
    params[:per_page] || 30
  end

  def results
    search = EcoCoupon.search do
      with :number, params[:number] if (params.try(:[], :number)).present?

      order_by :issued_at, :asc

      paginate :page => page, :per_page => per_page
    end

    search.results
  end
end
