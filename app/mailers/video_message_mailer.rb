class VideoMessageMailer < ActionMailer::Base
  default from: Settings['mail.video_message.sender']

  def published_video_message(video_message)
    @video_message = video_message
    mail(to: video_message.email, subject: 'Ваше видеообращение и ответ на него опубликованы')
  end

  def unpublished_video_message(video_message)
    @video_message = video_message
    mail(to: video_message.email, subject: 'Ваше видеообращение и ответ на него снаты с публикации')
  end
end
