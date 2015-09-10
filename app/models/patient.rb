class Patient < ActiveRecord::Base
  attr_accessible :code

  has_many :coupons
end

# == Schema Information
#
# Table name: patients
#
#  id         :integer          not null, primary key
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
