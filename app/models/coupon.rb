class Coupon < ActiveRecord::Base
  include AASM

  attr_accessor :patient_code_id

  attr_accessible :number, :issued_on, :patient_id, :patient_code_id, :state

  before_save :set_uniq_number

  validate :check_opened_coupons

  belongs_to :patient
  delegate :code, :to => :patient, :prefix => true

  default_value_for (:issued_on) { Time.zone.now }

  searchable do
    string :number
    time :issued_on
  end


  aasm :column => 'state'

  aasm do
    state :created, :initial => true
    state :wait
    state :approved

    state :closed
  end

  def check_opened_coupons
    patient = Patient.find_or_create_by(code: patient_code_id)

    if patient.coupons.map(&:state).any?
      errors.add(:patient_code_id, 'У пациента есть открытые талоны, добавление невозможно')
    end
  end

  private

  def set_uniq_number
    patient = Patient.find_or_create_by(code: patient_code_id)

    self.patient_id = patient.id

    generated_number = generate_number

    while exist_numbers.include?(generated_number) do
      generated_number = generate_number
    end

    self.number = generated_number
  end

  def generate_number
    I18n.l(Time.zone.now, :format => '%Y%m') + 6.times.map { Random.rand(10) }.join
  end

  def exist_numbers
    @exist_numbers ||= Coupon.pluck(:number)
  end
end

# == Schema Information
#
# Table name: coupons
#
#  id         :integer          not null, primary key
#  number     :string
#  issued_on  :datetime
#  created_at :datetime
#  updated_at :datetime
#  patient_id :integer
#  state      :string
#
