class Manage::EvaluationRegistriesController < Manage::ApplicationController

  inherit_resources

  has_scope :ordered, :default => 1, :only => :index

  def index
    index! { @evaluation_registries = Kaminari.paginate_array(collection).page(params[:page]).per(15) }
  end

  def xls
    if params['year'].blank?
      evaluation_registries = EvaluationRegistry.ordered(1)
      filename = 'statistics.xls'
    else
      evaluation_registries = EvaluationRegistry.by_year(params['year'])
      filename = %(statistics-#{params['year']}.xls)
    end
    send_data EvaluationRegistriesXls.new(evaluation_registries).xls, filename: filename
  end

end
