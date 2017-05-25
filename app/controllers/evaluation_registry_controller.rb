class EvaluationRegistryController < MainController

  before_filter :prepare_cms

  def new
    @evaluation_registry = EvaluationRegistry.new
  end

  def create
    @evaluation_registry = EvaluationRegistry.new(params[:evaluation_registry])
    @evaluation_registry.ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
    @evaluation_registry.user_agent = request.user_agent
    if @evaluation_registry.save && verify_recaptcha
      EvaluationRegistryMailer.delay(retry: false).new_evaluation_registry_email(@evaluation_registry)
      flash[:notice] = 'Ваши ответы на антеку приняты к сведению. Спасибо за Ваше участие!'
      redirect_to :action => :show
    else
      @evaluation_registry.errors.add(:recaptcha, I18n.t('recaptcha.failure'))
      flash.now[:alert] = I18n.t('recaptcha.failure')
      render :new
    end
  end

end
