class ThanksController < MainController

  before_filter :prepare_cms

  inherit_resources

  actions :all, :only => :new

  has_scope :by_state, :default => 'published', :only => :index

  def index
    index! { @thanks = Kaminari.paginate_array(collection).page(params[:page]).per(10) }
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
