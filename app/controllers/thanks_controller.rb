class ThanksController < MainController
  inherit_resources

  actions :all, :only => :new

  layout 'public'

  def index
    @thanks = Thank.published
  end

  def create
    page_regions.each do |region|
      eval "@#{region} = page.regions.#{region}"
    end

    @page_title = page.title
    @page_meta = page.meta
    @link_to_json = remote_url

    @thank = Thank.new(params[:thank])

    if verify_recaptcha(:model => @thank)
      super
    else
      flash.now[:alert] = I18n.t('recaptcha.failure')
      flash.delete :recaptcha_error
      render :new
    end
  end
end
