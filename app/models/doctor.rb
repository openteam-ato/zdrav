class Doctor < ActiveRecord::Base
  attr_accessible :name, :post, :description

  validates :name, :presence => true, :uniqueness => true
end

# == Schema Information
#
# Table name: doctors
#
#  id          :integer          not null, primary key
#  name        :text
#  post        :text
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
