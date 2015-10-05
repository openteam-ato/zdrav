class Coupon < ActiveRecord::Base

  include CouponHistory
  attr_accessor :patient_code_id, :mi_title

  attr_accessible :number, :patient_code_id, :patient_id, :workflow_state, :created_on, :issued_on, :mi_title,
                  :medical_institution_id, :not_need_help_on, :failure_patient_on, :help_provided_on, :closed_on

  belongs_to :patient
  belongs_to :medical_institution

  before_create :set_uniq_number

  validates_presence_of :patient_code_id, :if => -> { created? && patient_code_id }
  validates_presence_of :mi_title, :if => -> { (created? || issued?) && mi_title }

  validate :check_opened_coupons, :on => :create
  validate :validate_issued_on,             :if => :issued_on
  validate :validate_not_need_help_on,      :if => :not_need_help_on
  validate :validate_failure_patient_on,    :if => :failure_patient_on
  validate :validate_help_provided_on,      :if => :help_provided_on
  validate :validate_closed_on,             :if => :closed_on


  delegate :code, :to => :patient, :prefix => true, :allow_nil => true
  delegate :title, :to => :medical_institution, :prefix => true, :allow_nil => true

  has_paper_trail

  scope :by_state,  -> (state) { where :workflow_state => state }

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
    state :failure_patient
    state :help_provided
    state :closed

    event :to_issued do
      transitions :from => :created, :to => :issued, :if => ->{ issued_on? && mi_title.present? }, :after => :set_medical_institution
    end

    event :to_not_need_help do
      transitions :from => :created, :to => :not_need_help, :if => ->{ not_need_help_on? }

      after do |coupon|
        self.closed_on = self.not_need_help_on
        self.to_closed
      end
    end

    event :to_failure_patient do
      transitions :from => :issued, :to => :failure_patient, :if => ->{ failure_patient_on? }

      after do |coupon|
        self.closed_on = self.failure_patient_on
        self.to_closed
      end
    end

    event :to_help_provided do
      transitions :from => :issued, :to => :help_provided, :if => ->{ help_provided_on? }

      after do |coupon|
        self.closed_on = self.help_provided_on
        self.to_closed
      end
    end

    event :to_closed do
      transitions :from => :not_need_help, :to => :closed, :if => ->{ closed_on? }
      transitions :from => :failure_patient, :to => :closed, :if => ->{ closed_on? }
      transitions :from => :help_provided, :to => :closed, :if => ->{ closed_on? }
    end

    event :rollback do
      transitions :from => :issued, :to => :created, :after => :clear_issued_info
      transitions :from => :help_provided, :to => :issued, :after => :clear_help_provided_info
      transitions :from => :failure_patient, :to => :issued, :after => :clear_failure_patient_info
      transitions :from => :closed, :to => :created, :after => :clear_closed_info, :if =>  ->{ not_need_help_on? }
      transitions :from => :closed, :to => :issued, :after => :clear_closed_info, :if =>  ->{ failure_patient_on? }
      transitions :from => :closed, :to => :issued, :after => :clear_closed_info, :if =>  ->{ help_provided_on? }
    end
  end


  def previous_state
    previous_version.workflow_state
  end

  private

  {
   "issued_on" => "created_on", "not_need_help_on" => "created_on",
   "failure_patient_on" => "issued_on", "help_provided_on" => "issued_on"
  }.each do |key,value|
    define_method "validate_#{key}" do
    if self[key] < self[value]
      errors.add(key, I18n.t("coupon.errors.#{key}"))
    end
    end
  end

  def validate_closed_on
    state = %w(not_need_help_on failure_patient_on help_provided_on).select { |s| self[s].present? }.first

    if self.closed_on < self[state]
      errors.add(:closed_on, I18n.t("coupon.errors.closed_on.#{state}"))
    end
  end

  (Coupon.aasm.states.map(&:name) - [:issued, :closed]).each do |state|
    define_method "clear_#{state}_info" do
      self["#{state}_on"] = nil
    end
  end

  def clear_issued_info
    self.issued_on = nil
    self.medical_institution = nil
  end

  def clear_closed_info
    self.closed_on = nil
    self.not_need_help_on = nil
    self.help_provided_on = nil
    self.failure_patient_on = nil
  end

  def self.opened_states
    (Coupon.aasm.states.map(&:name) - [:closed]).map(&:to_s)
  end

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
    self.number = generate_number
  end

  def generate_number
    codes_by_year = Coupon.where(:created_on => Date.parse("01.01.#{created_on.year}")..Date.parse("31.12.#{created_on.year}")).pluck(:number).sort
    if codes_by_year.present?
      last_number = codes_by_year.last.to_i
      last_number+=1
    else
      "#{I18n.l(created_on, :format => '%Y')}0001".to_i
    end
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
#  not_need_help_on       :date
#  failure_patient_on     :date
#  help_provided_on       :date
#  closed_on              :date
#
