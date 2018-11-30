class HumanReservClaim < ActiveRecord::Base
  extend Enumerize
  include AASM

  validates :fullname, :old_post, :old_organization, :reserv_date, :reserv_level, presence: true

  default_scope { order('created_at DESC') }

  enumerize :reserv_level, in: [:basic, :middle, :high]

  aasm :state, whiny_transitions: false do
    state :draft, initial: true
    state :appointed

    event :approve do
      transitions from: :draft, to: :appointed
    end
  end
end
