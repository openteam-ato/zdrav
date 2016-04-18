class Manage::VideoMessagesController < Manage::ApplicationController

  def index
    @video_messages = VideoMessage.ordered.page(params[:page]).per(params[:per_page])
  end

  def publish
    video_message = VideoMessage.find(params[:video_message_id])
    unless video_message.publish!
      flash[:alert] = 'Видео обращение нельзя опубликовать без прикреплённых сконвертированных вопроса и ответа'
    else
      VideoMessageMailer.delay.published_video_message(video_message)
    end
    redirect_to manage_video_message_path(video_message)
  end

  def unpublish
    video_message = VideoMessage.find(params[:video_message_id])
    video_message.unpublish!
    VideoMessageMailer.delay.unpublished_video_message(video_message)
    redirect_to manage_video_message_path(video_message)
  end

end
