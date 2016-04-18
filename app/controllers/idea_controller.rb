class IdeaController < MainController

  before_filter :prepare_cms

  def create
    if verify_recaptcha
      IdeaMailer.delay.new_idea_email(params['idea'])
      flash[:notice] = 'Предложенная Вами идея принята к сведению. Спасибо за Ваше обращение!'
      redirect_to :action => :show
    else
      flash.now[:alert] = I18n.t('recaptcha.failure')
      render :show
    end
  end

end
