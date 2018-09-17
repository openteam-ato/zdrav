class Manage::DeclarationSupportsController < Manage::ApplicationController
  def update
    if @declaration_support.update(declaration_support_params)
      redirect_to manage_declaration_supports_path, notice: 'Данные успешно обновлены!'
    else
      render 'edit'
    end
  end

  def approve
    @declaration_support.approve!

    redirect_to manage_declaration_supports_path
  end

  def unpublish
    @declaration_support.unpublish!

    redirect_to manage_declaration_supports_path
  end

  private

  def declaration_support_params
    params.require(:declaration_support).permit(:job)
  end
end
