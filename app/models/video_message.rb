class VideoMessage < ActiveRecord::Base

  attr_accessible :target, :title, :name, :phone, :email, :aasm_state,
    :question_source, :question_converted,
    :answer_source, :answer_converted

  validates_presence_of :target, :title, :name, :email, :question_source
  #validates :uniqueness_of_question_source # TODO: надо реализовать уникальность загружаемых видео обращений

  scope :ordered, -> { order('created_at desc') }

  normalize_attributes :title, :name, :phone, :email

  extend Enumerize
  enumerize :target,
    in: [:specialist, :pharmacist, :doctor, :other],
    predicates: true

  include AASM
  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published

    event :publish, guards: :converted_videos_present? do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  def converted_videos_present?
    question_converted.present? && answer_converted.present?
  end

  has_attached_file :question_source,
    path: ':rails_root/public/:class/:id/:attachment/:filename',
    url:  '/:class/:id/:attachment/:filename'
  validates_attachment :question_source, presence: true,
    content_type: { content_type: /\Avideo/ }

  has_attached_file :question_converted,
    path: ':rails_root/public/:class/:id/:attachment/:filename',
    url:  '/:class/:id/:attachment/:filename'
  validates_attachment :question_converted,
    content_type: { content_type: /\Avideo/ }

  has_attached_file :answer_source,
    path: ':rails_root/public/:class/:id/:attachment/:filename',
    url:  '/:class/:id/:attachment/:filename'
  validates_attachment :answer_source,
    content_type: { content_type: /\Avideo/ }

  has_attached_file :answer_converted,
    path: ':rails_root/public/:class/:id/:attachment/:filename',
    url:  '/:class/:id/:attachment/:filename'
  validates_attachment :answer_converted,
    content_type: { content_type: /\Avideo/ }

end

# == Schema Information
#
# Table name: video_messages
#
#  id                              :integer          not null, primary key
#  target                          :string
#  title                           :string
#  name                            :string
#  phone                           :string
#  email                           :string
#  aasm_state                      :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  question_source_file_name       :string
#  question_source_content_type    :string
#  question_source_file_size       :integer
#  question_source_updated_at      :datetime
#  question_source_url             :text
#  question_source_fingerprint     :string
#  question_converted_file_name    :string
#  question_converted_content_type :string
#  question_converted_file_size    :integer
#  question_converted_updated_at   :datetime
#  question_converted_url          :text
#  question_converted_fingerprint  :string
#  answer_source_file_name         :string
#  answer_source_content_type      :string
#  answer_source_file_size         :integer
#  answer_source_updated_at        :datetime
#  answer_source_url               :text
#  answer_source_fingerprint       :string
#  answer_converted_file_name      :string
#  answer_converted_content_type   :string
#  answer_converted_file_size      :integer
#  answer_converted_updated_at     :datetime
#  answer_converted_url            :text
#  answer_converted_fingerprint    :string
#
