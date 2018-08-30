class DeclarationSupport < ActiveRecord::Base
  include AASM

  validates :name, :surname, :agreement, :job, presence: true
  validates :email, presence: true, email_format: true

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
