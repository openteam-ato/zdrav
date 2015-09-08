class EcoCoupon < ActiveRecord::Base
  attr_accessible :number, :patient_code, :issued_at, :closing_at

  default_value_for (:issued_at) { Time.zone.now }

  searchable do
    string :number
    time :issued_at
  end

end

# == Schema Information
#
# Table name: eco_coupons
#
#  id           :integer          not null, primary key
#  number       :string(255)
#  patient_code :string(255)
#  issued_at    :datetime
#  closing_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
