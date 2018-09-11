class ClaimsController < MainController
  before_filter :prepare_cms
  before_filter :set_new_claim, only: [:new, :another_confirmation_email]

  def new; end

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

  def another_confirmation_email; end

  def send_another_confirmation_email
    @claim = Claim.find_by claim_params

    if verify_recaptcha(model: @claim) && @claim.present?
      @claim.confirmation
      @claim.save

      render 'confirmate'
    else
      @claim = Claim.new
      @claim.errors.add(:email, 'не найдена')

      render 'another_confirmation_email'
    end
  end

  private

  def set_new_claim
    @claim = Claim.new
  end

  def claim_params
    params.require(:claim).permit(:name, :surname, :patronymic, :email)
  end
end
