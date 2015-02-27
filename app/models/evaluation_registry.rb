class EvaluationRegistry < ActiveRecord::Base
  attr_accessible :title, :proposal, :ip, :user_agent,
    :question_1_1, :question_1_2, :question_1_3, :question_1_4, :question_1_5, :question_1_6,
    :question_1_7, :question_1_8, :question_1_9, :question_1_10, :question_1_11,
    :question_2_1, :question_2_2, :question_2_3, :question_2_4, :question_2_5, :question_2_6,
    :question_2_7, :question_2_8, :question_2_9,
    :question_3_1, :question_3_2, :question_3_3, :question_3_4, :question_3_5, :question_3_6,
    :question_4_1, :question_4_2, :question_4_3, :question_5_1, :question_5_2,
    :evaluation_registry_attachments_attributes

  validates_presence_of :title,
    :question_1_1, :question_1_2, :question_1_3, :question_1_4, :question_1_5, :question_1_6,
    :question_1_7, :question_1_8, :question_1_9, :question_1_10, :question_1_11,
    :question_2_1, :question_2_2, :question_2_3, :question_2_4, :question_2_5, :question_2_6,
    :question_2_7, :question_2_8, :question_2_9,
    :question_3_1, :question_3_2, :question_3_3, :question_3_4, :question_3_5, :question_3_6,
    :question_4_1, :question_4_2, :question_4_3, :question_5_1, :question_5_2

  has_many :evaluation_registry_attachments, :dependent => :destroy
  accepts_nested_attributes_for :evaluation_registry_attachments, :allow_destroy => true

  normalize_attributes :title, :proposal
end

# == Schema Information
#
# Table name: evaluation_registries
#
#  id            :integer          not null, primary key
#  title         :text
#  question_1_1  :integer
#  question_1_2  :integer
#  question_1_3  :integer
#  question_1_4  :integer
#  question_1_5  :integer
#  question_1_6  :integer
#  question_1_7  :integer
#  question_1_8  :integer
#  question_1_9  :integer
#  question_1_10 :integer
#  question_1_11 :integer
#  question_2_1  :integer
#  question_2_2  :integer
#  question_2_3  :integer
#  question_2_4  :integer
#  question_2_5  :integer
#  question_2_6  :integer
#  question_2_7  :integer
#  question_2_8  :integer
#  question_2_9  :integer
#  question_3_1  :integer
#  question_3_2  :integer
#  question_3_3  :integer
#  question_3_4  :integer
#  question_3_5  :integer
#  question_3_6  :integer
#  question_4_1  :integer
#  question_4_2  :integer
#  question_4_3  :integer
#  question_5_1  :integer
#  question_5_2  :integer
#  proposal      :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ip            :text
#  user_agent    :text
#
