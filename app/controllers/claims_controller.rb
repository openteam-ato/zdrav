class ClaimsController < MainController
  before_filter :prepare_cms

  def new
    @claim = Claim.new
  end

  def create
    @claim = Claim.new claim_params

    if verify_recaptcha(model: @claim) && @claim.save
      render 'confirmate'
    else
      render 'new'
    end
  end

  def confirmation
    @claim = Claim.find_by confirmation_token: params[:confirmation_token]
    @claim.confirmed! if @claim
  end

  private

  def claim_params
    params.require(:claim).permit(:name, :surname, :patronymic, :email)
  end
end
