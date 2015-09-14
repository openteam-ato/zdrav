class Coupon < ActiveRecord::Base

  attr_accessor :patient_code_id, :mi_title

  attr_accessible :number, :patient_code_id, :patient_id, :workflow_state, :created_on, :issued_on, :mi_title

  belongs_to :medical_institution
  belongs_to :patient

  before_save :set_uniq_number, :if => :patient_code_id
  before_save :set_medical_institution, :if => :mi_title

  validates_presence_of :patient_code_id, :created_on, :on => :create
  validate :check_opened_coupons, :on => :create

  delegate :code, :to => :patient, :prefix => true, :allow_nil => true
  delegate :title, :to => :medical_institution, :prefix => true, :allow_nil => true


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

  include Workflow

  workflow do
    state :created do # талон выдан
      event :issue, :transitions_to => :issued
    end

    state :issued do # выдано направление в МУ
      event :approve, :transitions_to => :approved
      event :not_need_help_trigger, :transitions_to => :not_need_help
    end

    state :not_need_help do # нет наличия показаний
      event :close, :transitions_to => :closed
    end

    state :approved do # есть наличие показаний
      event :failure_patient_trigger, :transitions_to => :failure_patient
      event :help_provided_trigger, :transitions_to => :help_provided
    end

    state :failure_patient do # отказ пациента
      event :close, :transitions_to => :closed
    end

    state :help_provided do # помощ оказана
      event :close, :transitions_to => :closed
    end

    state :closed # талон закрыт

    on_error do |error, from, to, event, *args|
      logger.info "Exception (#{error.class}) on #{from} -> #{to}"
    end

  end

  def self.opened_states
    (Coupon.workflow_spec.states.keys - [:closed]).map(&:to_s)
  end

  private

  def check_opened_coupons
    self.patient = Patient.find_or_create_by(:code => patient_code || patient_code_id)

    if (Coupon.opened_states & self.patient.coupons.map(&:workflow_state).uniq).any?
      errors.add(:patient_code_id, 'У пациента есть открытые талоны, добавление невозможно')
    end
  end

  def set_medical_institution
    mi = MedicalInstitution.find_or_create_by(title: mi_title)
    self.medical_institution = mi
    self.issue!
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
#  id             :integer          not null, primary key
#  number         :string
#  created_at     :datetime
#  updated_at     :datetime
#  patient_id     :integer
#  workflow_state :string
#  issued_on      :date
#  created_on     :date
#
