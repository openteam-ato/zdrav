class DeclarationSupport < ActiveRecord::Base
  include AASM

  validates :name, :surname, :agreement, presence: true
  validates :email, email_format: true, if: -> { email.present? }
  validate  :job_presence

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

  def job_presence
    if regional_institution_job.blank? && job.blank?
      errors.add(:workplace, "Необходимо указать место работы")
    end
  end

  def self.regional_institutions
    url = "#{Settings['cms.url']}/nodes/zdrav/ru/oblastnye-uchrezhdeniya.json"

    @regional_institutions ||= RestClient.get(url, :content_type => :json, :accept => :json) do |response, request, result|
      begin
        result = JSON.load(response)['page']['regions']['content_first']['content']['oblastnye-uchrezhdeniya']['children']
        result_hash = {}

        result.each do |key, value|
          result_hash[value['title']] = value['children'].map do |sub_key, sub_value|
            sub_value['title']
          end
        end

        result_hash.to_a
      rescue
        []
      end
    end
  end
end
