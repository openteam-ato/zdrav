class Manage::HumanReservClaimsController < Manage::ApplicationController
  load_resource

  def index; end

  def create
    @human_reserv_claim = HumanReservClaim.create human_reserv_claim_params

    if @human_reserv_claim.errors.present?
      render :new
    else
      redirect_to manage_human_reserv_claims_path
    end
  end

  private

  def human_reserv_claim_params
    params.require(:human_reserv_claim).permit(:fullname, :birthdate, :old_post,
      :old_organization, :reserv_date, :reserv_level, :curator_fullname)
  end
end
