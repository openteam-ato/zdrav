class Manage::DeclarationSupportsController < Manage::ApplicationController
  def approve
    @declaration_support.approve!

    redirect_to manage_declaration_supports_path
  end

  def unpublish
    @declaration_support.unpublish!

    redirect_to manage_declaration_supports_path
  end
end
