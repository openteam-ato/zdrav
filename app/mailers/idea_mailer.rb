class IdeaMailer < ActionMailer::Base
  default :from => Settings['mail.idea.sender']

  def new_idea_email(idea)
    @idea = idea
    mail(:to => Settings['mail.idea.recipient'], :subject => 'Новое предложение для биржи идей')
  end
end
