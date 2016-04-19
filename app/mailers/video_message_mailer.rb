class VideoMessageMailer < ActionMailer::Base

  default from: Settings['mail.video_message.sender']

  def created_video_message(video_message)
    @video_message = video_message
    mail(to: Settings['mail.video_message.recipient'], subject: 'Добавлено новое видеообращение')
  end

  def published_video_message(video_message)
    @video_message = video_message
    mail(to: video_message.email, subject: 'Ваше видеообращение и ответ на него опубликованы')
  end

  def unpublished_video_message(video_message)
    @video_message = video_message
    mail(to: video_message.email, subject: 'Ваше видеообращение и ответ на него сняты с публикации')
  end

  def deleted_video_message(video_message)
    @video_message = video_message
    mail(to: video_message.email, subject: 'Ваше видеообращение и ответ на него удалены')
  end

end
