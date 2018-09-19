class Manage::ClaimsController < Manage::ApplicationController
  %i(approve reject).each do |action|
    define_method(action) do
      claim = Claim.find_by id: params[:id]
      claim.send("#{action}!".to_sym) if claim

      redirect_to manage_claims_path
    end
  end

  def send_confirmation_email
    @claim = Claim.find_by id: params[:id]

    if @claim.present?
      @claim.confirmation
      @claim.save
    end

    redirect_to manage_claims_path
  end

  def send_accept_email
    @claim = Claim.find_by id: params[:id]

    if @claim.present?
      ClaimsMailer.delay(retry: false).approve_email(@claim.email, @claim.authorize_token)
    end

    redirect_to manage_claims_path
  end
end
