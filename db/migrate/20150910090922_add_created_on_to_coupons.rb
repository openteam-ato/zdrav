class AddCreatedOnToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :created_on, :date
  end
end
