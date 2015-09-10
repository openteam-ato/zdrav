class RenameEcoCouponToCoupon < ActiveRecord::Migration
  def change
    rename_table :eco_coupons, :coupons

    rename_column :coupons, :issued_at, :issued_on
  end
end
