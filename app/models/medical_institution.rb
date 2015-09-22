class MedicalInstitution < ActiveRecord::Base

  attr_accessible :title

  searchable do
    string :title
    text   :title
  end

end

# == Schema Information
#
# Table name: medical_institutions
#
#  id         :integer          not null, primary key
#  title      :string
#  coupon_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
