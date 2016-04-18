class EvaluationRegistryMailer < ActionMailer::Base
  default from: Settings['mail.evaluation_registry.sender']

  def new_evaluation_registry_email(evaluation_registry)
    @evaluation_registry = evaluation_registry
    mail(to: Settings['mail.evaluation_registry.recipient'], subject: 'Новая анкета конкурса «Поликлиника начинается с регистратуры»')
  end
end
