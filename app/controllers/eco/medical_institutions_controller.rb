class Eco::MedicalInstitutionsController < Eco::ApplicationController

  def index
    result = MedicalInstitution.search do
      fulltext params[:term]
    end
    render :json => result.results.map(&:title)
  end

end
