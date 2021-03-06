class User < ActiveRecord::Base
  sso_auth_user

  accepts_nested_attributes_for :permissions, allow_destroy: true

  scope :ordered, -> { order(:name) }

  Permission.available_roles.each do |role|
    define_method "#{role}?" do
      available_permissions.include? role
    end
  end

  def available_permissions
    @available_permissions ||= permissions.pluck(:role)
  end

  def staff?
    admin?
  end
end

# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  uid                :string(255)
#  name               :text
#  email              :text
#  raw_info           :text
#  sign_in_count      :integer
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
