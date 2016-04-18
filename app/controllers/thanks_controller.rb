class ThanksController < MainController

  before_filter :prepare_cms

  inherit_resources

  actions :all, :only => :new

  custom_actions :resource => :publish

  has_scope :by_state, :default => 'published', :only => :index

  def index
    index! { @thanks = Kaminari.paginate_array(collection).page(params[:page]).per(5) }
  end

  def create
    @thank = Thank.new(params[:thank])
    @thank.ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
    @thank.user_agent = request.user_agent
    if verify_recaptcha(:model => @thank)
      ThanksMailer.delay.new_thank_email(@thank)
      flash[:notice] = 'Ваша благодарность принята. Спасибо!'
      super
    else
      flash.now[:alert] = I18n.t('recaptcha.failure')
      render :new
    end
  end

  def publish
    @thank = Thank.find_by(:key => params['key'])

    render :not_found and return if @thank.blank?

    if @thank.fullname.slugged == params['author'] && @thank.draft?
      @thank.change!
    end
  end

  def remove
    @thank = Thank.find_by_key(params['key'])
    @thank_status = :not_found and return if @thank.blank?
    if @thank.fullname.slugged == params['author'] && @thank.draft?
      @thank.destroy
      @thank_status = :removed
    end
    @thank_status = :published
  end

end
