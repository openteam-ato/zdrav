class Manage::HumanReservClaimsController < Manage::ApplicationController
  load_resource

  def index
    if params['search'].present?
      @human_reserv_claims = Searchers::HumanReservClaimSearcher.new(params['search']).collection
    end
  end

  def create
    @human_reserv_claim = HumanReservClaim.create human_reserv_claim_params

    if @human_reserv_claim.errors.present?
      render :new
    else
      redirect_to manage_human_reserv_claims_path
    end
  end

  def update
    if @human_reserv_claim.update human_reserv_claim_params
      redirect_to manage_human_reserv_claims_path
    else
      render :edit
    end
  end

  def appoint; end

  def approve
    @human_reserv_claim.update human_reserv_claim_params

    if @human_reserv_claim.approve!
      redirect_to manage_human_reserv_claims_path
    else
      render :appoint
    end
  end

  private

  def human_reserv_claim_params
    params.require(:human_reserv_claim).permit(:fullname, :birthdate, :old_post,
      :old_organization, :reserv_date, :reserv_level, :curator_fullname,
      :new_post, :new_organization, :appointed_date)
  end
end
