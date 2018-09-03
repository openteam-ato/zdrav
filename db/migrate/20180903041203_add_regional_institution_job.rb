class AddRegionalInstitutionJob < ActiveRecord::Migration
  def change
    add_column :declaration_supports, :regional_institution_job, :string
  end
end
