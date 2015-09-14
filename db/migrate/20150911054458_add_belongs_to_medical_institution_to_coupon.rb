class AddBelongsToMedicalInstitutionToCoupon < ActiveRecord::Migration
  def change
    add_reference :coupons, :medical_institution
  end
end
