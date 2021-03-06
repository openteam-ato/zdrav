class DoctorsController < MainController

  before_filter :prepare_cms

  inherit_resources

  has_scope :ordered, :default => 1, :only => :index

  def index
    index! { @doctors = Kaminari.paginate_array(collection).page(params[:page]).per(5) }
  end

end
