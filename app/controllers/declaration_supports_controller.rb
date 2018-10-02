class DeclarationSupportsController < MainController
  before_filter :prepare_cms

  def index
    @declaration_supports = DeclarationSupport.approved
  end

  def new
    @declaration_support = DeclarationSupport.new
  end

  def create
    @declaration_support = DeclarationSupport.new(declaration_support_params)

    if verify_recaptcha(model: @declaration_support)
      if @declaration_support.save
        DeclarationSupportsMailer.delay(retry: false).new_declaration_support_email(@declaration_support)
        redirect_to show_declaration_support_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  private

  def declaration_support_params
    params.require(:declaration_support).permit(:name, :surname, :patronymic, :job, :email, :agreement, :regional_institution_job)
  end
end
