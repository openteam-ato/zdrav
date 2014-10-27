class ThanksMailer < ActionMailer::Base
  default :from => Settings['mail.thanks.sender']

  def new_thank_email(thank)
    @thank = thank
    mail(:to => Settings['mail.thank.recipient'], :subject => 'Новая благодарность от пациента')
  end
end
