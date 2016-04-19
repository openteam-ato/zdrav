class VideoMessagesController < MainController

  before_filter :prepare_cms

  def index
    @video_messages = VideoMessage.published.page(params[:page])
  end

  def show
    @video_message = VideoMessage.published.find(params[:id])
    @page_title = @video_message.title
    @breadcrumbs.content[@video_message.title] = video_message_path(@video_message)
  end

  def new
    @video_message = VideoMessage.new
  end

  def create
    @video_message = VideoMessage.new(params[:video_message])
    if @video_message.save
      VideoMessageMailer.delay.created_video_message(@video_message)
      render text: video_message_done_path and return if request.xhr?
    else
      @video_message.question_source = nil
      @video_message.question_converted = nil
      @video_message.answer_source = nil
      @video_message.answer_converted = nil
      render partial: 'form' and return if request.xhr?
      render :new
    end
  end

  def done
  end

end
