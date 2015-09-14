class AddFieldsToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :approved_on, :date
    add_column :coupons, :not_need_help_on, :date
    add_column :coupons, :failure_patient_on, :date
    add_column :coupons, :help_provided_on, :date
    add_column :coupons, :closed_on, :date
  end
end
