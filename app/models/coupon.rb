class Coupon < ActiveRecord::Base

  attr_accessor :patient_code_id, :mi_title

  attr_accessible :number, :patient_code_id, :patient_id, :workflow_state, :created_on, :issued_on, :mi_title,
                  :medical_institution_id,
                  :approved_on, :not_need_help_on, :failure_patient_on, :help_provided_on, :closed_on

  belongs_to :patient
  belongs_to :medical_institution

  before_create :set_uniq_number

  validates_presence_of :patient_code_id, :created_on, :if => -> { created? && patient_code_id }
  validate :check_opened_coupons, :on => :create
  validates_presence_of :mi_title, :issued_on, :if => -> { (created? || issued?) && mi_title }

  delegate :code, :to => :patient, :prefix => true, :allow_nil => true
  delegate :title, :to => :medical_institution, :prefix => true, :allow_nil => true

  has_paper_trail

  scope :by_state,  -> (state) { where :workflow_state => state }
  scope :created,   -> { by_state 'created' }
  scope :issued,    -> { by_state 'issued' }
  scope :approved,  -> { by_state 'approved' }
  scope :opened,    -> { by_state ['created', 'issued', 'approved'] }
  scope :closed,    -> { by_state 'closed' }

  searchable(:include => [:patient]) do
    string  :number
    string  (:patient_code) { patient.code }
    string  :workflow_state

    text    :number
    text    (:patient_code) { patient.code }

    date    :created_on
    date    :issued_on
    time    :updated_at
  end

  include AASM

  aasm :column => :workflow_state do
    state :created, :initial => true
    state :issued
    state :not_need_help
    state :approved
    state :failure_patient
    state :help_provided
    state :closed

    event :to_issued do
      transitions :from => :created, :to => :issued, :if => ->{ issued_on? && mi_title.present? }, :after => :set_medical_institution
    end

    event :to_not_need_help do
      transitions :from => :issued, :to => :not_need_help, :if => ->{ not_need_help_on? }
    end

    event :to_approved do
      transitions :from => :issued, :to => :approved, :if => ->{ approved_on? }
    end

    event :to_failure_patient do
      transitions :from => :approved, :to => :failure_patient, :if => ->{ failure_patient_on? }
    end

    event :to_help_provided do
      transitions :from => :approved, :to => :help_provided, :if => ->{ help_provided_on? }
    end

    event :to_closed do
      transitions :from => :not_need_help, :to => :closed, :if => ->{ closed_on? }
      transitions :from => :failure_patient, :to => :closed, :if => ->{ closed_on? }
      transitions :from => :help_provided, :to => :closed, :if => ->{ closed_on? }
    end

    event :rollback do
      transitions :from => :issued, :to => :created, :after => :clear_issued_info
      transitions :from => :not_need_help, :to => :issued, :after => :clear_not_need_help_info
      transitions :from => :approved, :to => :issued, :after => :clear_approved_info
      transitions :from => :help_provided, :to => :approved, :after => :clear_help_provided_info
      transitions :from => :failure_patient, :to => :approved, :after => :clear_failure_patient_info
      transitions :from => :closed, :to => :not_need_help, :after => :clear_closed_info, :if =>  ->{ not_need_help_on? }
      transitions :from => :closed, :to => :failure_patient, :after => :clear_closed_info, :if =>  ->{ failure_patient_on? }
      transitions :from => :closed, :to => :help_provided, :after => :clear_closed_info, :if =>  ->{ help_provided_on? }
    end
  end

  def clear_issued_info
    self.issued_on = nil
    self.medical_institution = nil
  end

  def clear_not_need_help_info
    self.not_need_help_on = nil
  end

  def clear_approved_info
    self.approved_on = nil
  end

  def clear_help_provided_info
    self.help_provided_on = nil
  end

  def clear_failure_patient_info
    self.failure_patient_on = nil
  end

  def clear_closed_info
    self.closed_on = nil
  end

  def self.opened_states
    (Coupon.aasm.states.map(&:name) - [:closed]).map(&:to_s)
  end

  def previous_state
    previous_version.workflow_state
  end

  private

  def check_opened_coupons
    self.patient = Patient.find_or_create_by(:code => patient_code_id)

    if (Coupon.opened_states & self.patient.coupons.map(&:workflow_state).uniq).any?
      errors.add(:patient_code_id, 'У пациента есть открытые талоны, добавление невозможно')
    end
  end

  def set_medical_institution
    mi = MedicalInstitution.find_or_create_by(title: mi_title)
    self.medical_institution_id = mi.id
  end

  def set_uniq_number
    self.patient = Patient.find_or_create_by(:code => patient_code || patient_code_id)

    generated_number = generate_number

    while exist_numbers.include?(generated_number) do
      generated_number = generate_number
    end

    self.number = generated_number
  end

  def generate_number
    I18n.l(Time.zone.now, :format => '%Y%m') + 6.times.map{ Random.rand(10) }.join
  end

  def exist_numbers
    @exist_numbers ||= Coupon.pluck(:number)
  end

end

# == Schema Information
#
# Table name: coupons
#
#  id                     :integer          not null, primary key
#  number                 :string
#  created_at             :datetime
#  updated_at             :datetime
#  patient_id             :integer
#  workflow_state         :string
#  issued_on              :date
#  created_on             :date
#  medical_institution_id :integer
#  approved_on            :date
#  not_need_help_on       :date
#  failure_patient_on     :date
#  help_provided_on       :date
#  closed_on              :date
#
