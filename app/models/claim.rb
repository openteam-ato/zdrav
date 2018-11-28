class Claim < ActiveRecord::Base
  include AASM

  validates :name, :surname, :email, presence: true
  validates :email, email_format: true
  validates :email, uniqueness: true

  default_scope { order('created_at DESC') }

  has_many :test_results, dependent: :destroy

  before_create :confirmation
  before_validation :downcase_email

  aasm :state, whiny_transitions: false do
    state :pending, initial: true
    state :draft
    state :approved
    state :rejected

    event :confirme, after: [:send_mail, :update_confirmed_at] do
      transitions from: :pending, to: :draft
    end

    event :approve, after: [:send_mail, :create_test_result] do
      transitions from: :draft, to: :approved
    end

    event :reject, after: :send_mail do
      transitions from: :draft, to: :rejected
    end
  end

  def fullname
    "#{surname} #{name} #{patronymic}".squish
  end

  def confirmation
    self.confirmation_token = SecureRandom.hex
    self.authorize_token = SecureRandom.hex(6)
    self.confirmation_sent_at = Time.zone.now

    ClaimsMailer.delay(retry: false)
                .confirmation_email(self.confirmation_token, self.email)
  end

  def test_result
    test_results.order(:created_at).last
  end

  def unfinished_test?
    test_results.pluck(:finished).include? false
  end

  def create_test_result
    test_results.create
  end

  private

  def downcase_email
    self.email = self.email.squish.downcase
  end

  def send_mail
    case state
    when 'draft'
      ClaimsMailer.delay(retry: false).new_email(self.id)
    when 'approved'
      ClaimsMailer.delay(retry: false).approve_email(self.email, self.authorize_token)
    when 'rejected'
      ClaimsMailer.delay(retry: false).reject_email(self.email)
    end
  end

  def update_confirmed_at
    self.confirmed_at = Time.zone.now
    save
  end
end
