class Permission < ActiveRecord::Base
  sso_auth_permission :roles => [:manager]

  attr_accessible :role

  belongs_to :user
end
