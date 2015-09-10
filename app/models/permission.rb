class Permission < ActiveRecord::Base
  attr_accessible :role
  sso_auth_permission :roles => [:admin, :manager, :operator]
end

# == Schema Information
#
# Table name: permissions
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  context_id   :integer
#  context_type :string
#  role         :string
#  created_at   :datetime
#  updated_at   :datetime
#
