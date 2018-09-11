class Claim < ActiveRecord::Base
  include AASM

  validates :name, :surname, :email, presence: true
  validates :email, email_format: true

  default_scope { order('created_at DESC') }

  aasm :state do
    state :pending
    state :draft
    state :approved
    state :rejected
  end

  def fullname
    "#{surname} #{name} #{patronymic}".squish
  end
end
