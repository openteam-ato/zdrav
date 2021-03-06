class NewModelMailer < ActionMailer::Base
  default from: Settings['mail.new_model.sender']

  def new_email(new_model)
    @new_model = new_model
    mail(to: Settings['mail.new_model.recipient'], from: @new_model['email'], subject: 'Новый вопрос или предложение о новой модели томского здравоохранения')
  end

  def new_offer_email(new_model)
    @new_model = new_model
    mail(to: Settings['mail.new_model.recipient'], from: @new_model['email'], subject: 'Новое предложение к проекту «Об утверждении государственной программы «Развитие здравоохранения в Томской области»')
  end
end
