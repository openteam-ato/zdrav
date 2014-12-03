module RemoteIndex

  extend ActiveSupport::Concern

  included do
    include ActionView::Helpers
    include ActionDispatch::Routing
    include Rails.application.routes.url_helpers
  end

  def reindex
    return if Rails.env.development?

    RestClient.post "#{Settings['cms.url']}/api",
                    :url => "#{Settings['app.url']}/#{url_for(self)}",
                    :content_type => :json,
                    :accept => :json if Settings['app.url']
  end

end
