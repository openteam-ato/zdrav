class IdeaMailer < ActionMailer::Base
  default :from => 'no-reply@dzato.tomsk.ru'

  def new_idea_email(idea)
    @idea = idea
    mail(:to => 'idea@dzato.tomsk.ru', :subject => 'Новое предложение для биржи идей')
  end
end
