class Coupon < ActiveRecord::Base
  attr_accessible :number, :patient_code, :issued_on

  default_value_for (:issued_on) { Time.zone.now }

  searchable do
    string :number
    time :issued_on
  end

end

# == Schema Information
#
# Table name: coupons
#
#  id           :integer          not null, primary key
#  number       :string
#  patient_code :string
#  issued_on    :datetime
#  closing_at   :datetime
#  created_at   :datetime
#  updated_at   :datetime
#
