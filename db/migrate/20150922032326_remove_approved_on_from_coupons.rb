class RemoveApprovedOnFromCoupons < ActiveRecord::Migration
  def change
    remove_column :coupons, :approved_on
  end
end
