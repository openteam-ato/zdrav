class Permission < ActiveRecord::Base
  extend Enumerize

  attr_accessible :role
  sso_auth_permission roles: [:admin, :manager, :operator]

  enumerize :role, in: [:admin, :manager, :operator]

  validates :role, uniqueness: { scope: [:user_id],
    message: 'У пользователя не может быть несколько одинаковых ролей!' }
end

# == Schema Information
#
# Table name: permissions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  context_id   :integer
#  context_type :string(255)
#  role         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
