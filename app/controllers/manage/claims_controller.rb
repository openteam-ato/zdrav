class Manage::ClaimsController < Manage::ApplicationController
  %i(approve reject).each do |action|
    define_method(action) do
      claim = Claim.find_by id: params[:id]
      claim.send("#{action}!".to_sym) if claim

      redirect_to manage_claims_path
    end
  end
end
