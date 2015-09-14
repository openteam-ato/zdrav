class Eco::MedicalInstitutionsController < Eco::ApplicationController
  def search
    result = MedicalInstitution.where("title ILIKE ?", "%#{params[:term]}%").pluck(:title)
    render :json => result
  end
end
