class TestsController < MainController
  before_filter :prepare_cms

  def authorize_entry; end

  def testing
    @claim = Claim.find_by claim_params

    unless @claim
      flash[:alert] = 'Вы ввели неверные данные!'
      render 'authorize_entry'
    end


  end

  private

  def claim_params
    params.require(:claim).permit(:authorize_token, :email)
  end
end
