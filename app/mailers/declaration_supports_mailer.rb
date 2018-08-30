class DeclarationSupportsMailer < ActionMailer::Base
  default from: Settings['mail.declaration.sender']

  def new_declaration_support_email(declaration_support)
    @declaration_support = declaration_support
    mail(to: Settings['mail.declaration_supports.recipient'], subject: 'Кто-то поддержал декларацию о пациент-ориентированном здравоохранении Томской области')
  end
end
