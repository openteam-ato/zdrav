class AddPatientIdToCoupon < ActiveRecord::Migration
  def up
    add_column :coupons, :patient_id, :integer
    add_column :coupons, :state, :string

    remove_column :coupons, :issued_on
    add_column :coupons, :issued_on, :date

    remove_column :coupons, :patient_code
    remove_column :coupons, :closing_at
  end

  def down
    remove_column :coupons, :patient_id
    remove_column :coupons, :state

    add_column :coupons, :issued_on, :datetime
    remove_column :coupons, :issued_on

    add_column :coupons, :patient_code, :integer
    add_column :coupons, :closing_at, :date
  end
end
