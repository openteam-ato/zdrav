class HumanReservClaimsController < MainController
  before_action :prepare_cms

  def index
    @human_reserv_claims = HumanReservClaim.draft
  end

  def approved_index
    @human_reserv_claims = HumanReservClaim.approved
  end
end
