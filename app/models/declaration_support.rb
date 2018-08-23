class DeclarationSupport < ActiveRecord::Base
  validates :name, :surname, :agreement, presence: true
  validates :email, presence: true, email_format: true
end
