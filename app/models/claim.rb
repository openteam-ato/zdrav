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

    event :confirmed, after: :send_new_claim_email do
      transitions from: :pending, to: :draft
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
end
