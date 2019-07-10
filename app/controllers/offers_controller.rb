class OffersController < MainController
  include SocialStatuses

  before_filter :prepare_cms
  before_action :set_social_statuses, only: [:show, :create]

  def show
  end

  def create
    if verify_recaptcha
      NewModelMailer.delay(retry: false).new_offer_email(params['new_model'])
      flash[:notice] = 'Информация о Вашем вопросе или предложении принята. Спасибо за Ваше обращение!'
      redirect_to :action => :show
    else
      flash.now[:alert] = I18n.t('recaptcha.failure')
      render :show
    end
  end

end
