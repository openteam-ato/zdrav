class ThanksController < MainController
  inherit_resources

  actions :all, :only => [:new, :create]

  layout 'public'

  def index
    @thanks = Thank.published
  end
end
