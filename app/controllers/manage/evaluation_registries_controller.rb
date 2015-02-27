class Manage::EvaluationRegistriesController < Manage::ApplicationController

  inherit_resources

  has_scope :ordered, :default => 1, :only => :index

  def index
    index! { @evaluation_registries = Kaminari.paginate_array(collection).page(params[:page]).per(15) }
  end

end
