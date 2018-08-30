class AddAasmStateToDeclarationSupport < ActiveRecord::Migration
  def change
    add_column :declaration_supports, :state, :string
  end
end
