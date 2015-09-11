class Patient < ActiveRecord::Base
  attr_accessible :code

  validates_uniqueness_of :code

  has_many :coupons, :dependent => :destroy
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
