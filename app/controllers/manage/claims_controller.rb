class Manage::ClaimsController < Manage::ApplicationController
  before_action :set_claim

  %i(approve reject).each do |action|
    define_method(action) do
      @claim.send("#{action}!".to_sym) if @claim

      redirect_to manage_claims_path
    end
  end

  def send_confirmation_email
    if @claim.present?
      @claim.confirmation
      @claim.save
    end

    redirect_to manage_claims_path
  end

  def send_accept_email
    if @claim.present?
      ClaimsMailer.delay(retry: false).approve_email @claim.email, @claim.authorize_token
    end

    redirect_to manage_claims_path
  end

  def send_test_result_email
    file = YAML.load_file('data/tests/personal_control_full.yml')
    @questions = file['questions']

    if @claim.try(:test_result).present?
      ClaimsMailer.delay(retry: false).test_results_email @claim.email, @claim.test_result.right_answers, @questions.count
    end

    redirect_to manage_claims_path
  end

  def add_new_test_result
    unless @claim.try(:unfinished_test?)
      @claim.create_test_result

      ClaimsMailer.delay(retry: false).approve_email @claim.email, @claim.authorize_token
    end

    redirect_to manage_claims_path
  end

  private

  def set_claim
    @claim = Claim.find_by id: params[:id]
  end
end
