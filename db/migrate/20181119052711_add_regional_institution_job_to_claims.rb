class AddRegionalInstitutionJobToClaims < ActiveRecord::Migration
  def change
    add_column :claims, :regional_institution_job, :string
  end
end
