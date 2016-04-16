class Manage::VideoMessagesController < Manage::ApplicationController

  def index
    @video_messages = VideoMessage.ordered.page(params[:page]).per(params[:per_page])
  end

end
