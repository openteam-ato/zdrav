class ClaimsMailer < ActionMailer::Base
  default from: Settings['mail.claim.sender']

  def confirmation_claim_email(token, email)
    @url = "#{confirmation_claim_url}?confirmation_token=#{token}"

    mail to: email,
         subject: 'Подтвердите адрес электронной почты'
  end

  def new_claim_email(id)
    mail to: Settings['mail.claim.recipient'],
         subject: 'Новая заявка'
  end
end
