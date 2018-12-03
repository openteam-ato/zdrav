class HumanReservClaim < ActiveRecord::Base
  extend Enumerize
  include AASM

  validates :fullname, :old_post, :old_organization, :reserv_date, :reserv_level, presence: true

  default_scope { order('created_at DESC') }

  enumerize :reserv_level, in: [:basic, :middle, :high]

  aasm :state, whiny_transitions: false do
    state :draft, initial: true
    state :approved

    event :approve do
      transitions from: :draft, to: :approved, guard: :can_approved?
    end
  end

  searchable do
    string :state
  end

  def can_approved?
    return false if [self.new_post, self.new_organization, self.appointed_date].include?(nil)
    return true
  end
end
