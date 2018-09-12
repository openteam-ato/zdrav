class Claim < ActiveRecord::Base
  include AASM

  validates :name, :surname, :email, presence: true
  validates :email, email_format: true
  validates :email, uniqueness: true

  default_scope { order('created_at DESC') }

  before_create :confirmation

  aasm :state, whiny_transitions: false do
    state :pending, initial: true
    state :draft
    state :approved
    state :rejected

    event :confirme, after: [:send_new_claim_email, :update_confirmed_at] do
      transitions from: :pending, to: :draft
    end

    event :approve do
      transitions from: :draft, to: :approved
    end

    event :reject do
      transitions from: :draft, to: :rejected
    end
  end

  def fullname
    "#{surname} #{name} #{patronymic}".squish
  end

  def confirmation
    self.confirmation_token = SecureRandom.hex
    self.confirmation_sent_at = Time.zone.now

    ClaimsMailer.delay(retry: false)
                .confirmation_claim_email(self.confirmation_token, self.email)
  end

  private

  def send_new_claim_email
    ClaimsMailer.delay(retry: false)
                .new_claim_email(self.id)
  end

  def update_confirmed_at
    self.confirmed_at = Time.zone.now
    save
  end
end
