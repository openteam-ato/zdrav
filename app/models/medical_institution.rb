class MedicalInstitution < ActiveRecord::Base
  has_many :coupons
end
