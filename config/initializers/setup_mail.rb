ActionMailer::Base.smtp_settings = {
  :address  => Settings['mail.smtp'],
  :port     => Settings['mail.port'],
  :domain   => Settings['mail.domain']
}
ActionMailer::Base.smtp_settings.merge!(:login => Settings['mail.login']) if Settings['mail.login'].present?
ActionMailer::Base.smtp_settings.merge!(:password => Settings['mail.password']) if Settings['mail.password'].present?
