class Manage::EvaluationRegistriesController < Manage::ApplicationController

  inherit_resources

  has_scope :ordered, :default => 1, :only => :index

  def index
    index! { @evaluation_registries = Kaminari.paginate_array(collection).page(params[:page]).per(15) }
  end

  def xls
    evaluation_registries = EvaluationRegistry.ordered(1)
    send_data EvaluationRegistriesXls.new(evaluation_registries).xls, :filename => 'statistics.xls'
  end

end
