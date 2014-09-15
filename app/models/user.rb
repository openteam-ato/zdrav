class User < ActiveRecord::Base
  sso_auth_user

  attr_accessible :name, :uid, :email

  has_many :permissions, :dependent => :destroy
end
