class Coupon < ActiveRecord::Base

  attr_accessor :patient_code_id, :mi_title

  attr_accessible :number, :patient_code_id, :patient_id, :workflow_state, :created_on, :issued_on, :mi_title,
                  :medical_institution_id,
                  :approved_on, :not_need_help_on, :failure_patient_on, :help_provided_on, :closed_on

  belongs_to :patient
  belongs_to :medical_institution

  before_create :set_uniq_number
  #before_save   :set_medical_institution, :if => :mi_title
  #after_save    :change_state_to_issued, :if => -> { issued_on && created? }
  #after_save    :change_state_to_not_need_help, :if => -> { not_need_help_on && issued? }
  #after_save    :change_state_to_approved, :if => -> { approved_on && issued? }
  #after_save    :change_state_to_failure_patient, :if => -> { failure_patient_on && approved? }
  #after_save    :change_state_to_closed, :if => -> { closed_on && (not_need_help? || failure_patient?) }

  validates_presence_of :patient_code_id, :if => -> { created? && patient_code.blank? }
  validates_presence_of :created_on
  #validates_presence_of :mi_title, :issued_on, :if => -> { (created? || issued?) && mi_title }
  #validate :check_opened_coupons, :on => :create

  delegate :code, :to => :patient, :prefix => true, :allow_nil => true
  delegate :title, :to => :medical_institution, :prefix => true, :allow_nil => true

  #scope :by_state,  -> (state) { where :workflow_state => state }
  #scope :created,   -> { by_state 'created' }
  #scope :issued,    -> { by_state 'issued' }
  #scope :approved,  -> { by_state 'approved' }
  #scope :opened,    -> { by_state ['created', 'issued', 'approved'] }
  #scope :closed,    -> { by_state 'closed' }

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

  #include Workflow

  #workflow do
    #state :created do # талон выдан
      #event :to_issued, :transitions_to => :issued, :if =>
    #end

    #state :issued do # выдано направление в МУ
      #event :to_approved, :transitions_to => :approved
      #event :to_not_need_help, :transitions_to => :not_need_help

      #event :to_created, :transitions_to => :created do
        #self.update_columns :medical_institution_id => nil, :issued_on => nil
      #end
    #end

    #state :not_need_help do # нет наличия показаний
      #event :to_issued, :transitions_to => :issued do
        #self.update_columns :not_need_help_on => nil
      #end

      #event :to_closed, :transitions_to => :closed
    #end

    #state :approved do # есть наличие показаний
      #event :to_failure_patient, :transitions_to => :failure_patient
      #event :to_help_provided, :transitions_to => :help_provided
    #end

    #state :failure_patient do # отказ пациента
      #event :to_closed, :transitions_to => :closed

      #event :to_approved, :transitions_to => :approved do
        #self.update_columns :failure_patient_on, nil
      #end
    #end

    #state :help_provided do # помощ оказана
      #event :to_closed, :transitions_to => :closed
    #end

    #state :closed do # талон закрыт
      #event :to_not_need_help, :transitions_to => :not_need_help do
        #self.update_columns :closed_on => nil
      #end

      #event :to_failure_patient, :transitions_to => :failure_patient do
        #self.update_columns :closed_on => nil
      #end
    #end

    #before_transition do |from, to, triggering_event, *event_args|
      #self.touch_with_version
    #end

    #on_error do |error, from, to, event, *args|
      #logger.info "Exception (#{error.class}) on #{from} -> #{to}"
    #end
  #end

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
      transitions :from => :issues, :to => :not_need_help, :if => ->{not_need_help_on?}
    end

    event :rollback do
      transitions :from => :issued, :to => :created, :after => :clear_issued_info
      transitions :from => :not_need_help, :to => :issued, :after => :clear_not_need_help_info
    end
  end

  def clear_issued_info
    self.issued_on = nil
    self.medical_institution = nil
  end

  def clear_not_need_help_info
    self.not_need_help_on = nil
  end

  has_paper_trail

  def self.opened_states
    (Coupon.workflow_spec.states.keys - [:closed]).map(&:to_s)
  end

  def previous_state
    previous_version.workflow_state
  end

  private

  %w( issued not_need_help closed approved failure_patient ).each do |evt|
    define_method "change_state_to_#{evt}" do
      self.send("to_#{evt}!")
    end
  end

  def check_opened_coupons
    self.patient = Patient.find_or_create_by(:code => patient_code || patient_code_id)

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
