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
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
