class DeclarationSupportsController < MainController
  before_filter :prepare_cms

  def new
    @declaration_support = DeclarationSupport.new
  end

  def create
    @declaration_support = DeclarationSupport.new(declaration_support_params)
    if @declaration_support.save
      redirect_to show_declaration_support_path
    else
      render 'new'
    end
  end

  private

  def declaration_support_params
    params.require(:declaration_support).permit(:name, :surname, :patronymic, :job, :email, :agreement)
  end
end
