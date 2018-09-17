class DeclarationSupport < ActiveRecord::Base
  include AASM

  validates :name, :surname, :agreement, presence: true
  validates :email, email_format: true, if: -> { email.present? }

  default_scope { order('created_at DESC') }

  aasm :state do
    state :created
    state :approved
    state :unpublished

    event :unpublish do
      transitions from: :approved, to: :unpublished
    end

    event :approve do
      transitions from: [:created, :unpublished], to: :approved
    end
  end

  def sender_fullname
    [
      surname,
      name,
      patronymic
    ].compact.join(' ')
  end
end
