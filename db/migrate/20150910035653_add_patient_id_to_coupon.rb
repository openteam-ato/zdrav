class AddPatientIdToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :patient_id, :integer

    remove_column :coupons, :patient_code
    remove_column :coupons, :closing_at
  end
end
