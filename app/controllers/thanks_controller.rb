class ThanksController < MainController

  before_filter :prepare_cms

  inherit_resources

  actions :all, :only => :new

  def index
    @thanks = Thank.published
  end

  def create
    @thank = Thank.new(params[:thank])
    if verify_recaptcha(:model => @thank)
      flash[:notice] = 'Ваша благодарность принята. Спасибо!'
      super
    else
      flash.now[:alert] = I18n.t('recaptcha.failure')
      render :new
    end
  end
end
