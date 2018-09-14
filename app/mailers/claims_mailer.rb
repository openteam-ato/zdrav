class ClaimsMailer < ActionMailer::Base
  default from: Settings['mail.claim.sender']

  def confirmation_email(token, email)
    @url = "#{confirmation_claim_url}?confirmation_token=#{token}"

    mail to: email,
         subject: 'Подтвердите адрес электронной почты'
  end

  def new_email(id)
    mail to: Settings['mail.claim.recipient'],
         subject: 'Новая заявка'
  end

  def reject_email(email)
    mail to: email,
         subject: 'Ваша заявка отклонена'
  end

  def approve_email(email, authorize_token)
    @token = authorize_token
    @email = email
    @test_url = authorize_entry_test_url

    mail to: @email,
         subject: 'Ваша заявка одобрена'
  end
end
