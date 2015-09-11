class EvaluationRegistry < ActiveRecord::Base

  attr_accessible :title, :username, :proposal, :ip, :user_agent,
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
    :question_2_8, :question_2_9,
    :question_3_1, :question_3_2, :question_3_3, :question_3_4, :question_3_5, :question_3_6,
    :question_4_1, :question_4_2, :question_4_3, :question_5_1, :question_5_2

  has_many :evaluation_registry_attachments, :dependent => :destroy
  accepts_nested_attributes_for :evaluation_registry_attachments, :allow_destroy => true

  normalize_attributes :title, :proposal

  scope :ordered, -> (_) { order('created_at desc') }

  def self.collection_for_title
    [
      'ОГАУЗ «Александровская районная больница»',
      'ОГАУЗ «Больница №2»',
      'ОГАУЗ «Врачебно-физкультурный диспансер»',
      'ОГАУЗ «Городская клиническая больница №3»',
      'ОГАУЗ «Детская больница №1»',
      'ОГАУЗ «Детская городская больница №2»',
      'ОГАУЗ «Детский центр восстановительного лечения»',
      'ОГАУЗ «Межвузовская больница»',
      'ОГАУЗ «МСЧ «Строитель»',
      'ОГАУЗ «Областной перинатальный центр»',
      'ОГАУЗ «Поликлиника №1»',
      'ОАУЗ «Поликлиника №3»',
      'ОГАУЗ «Поликлиника №4»',
      'ОГАУЗ «Поликлиника №8»',
      'ОГАУЗ «Поликлиника №10»',
      'ОГАУЗ «Родильный дом №4»',
      'ОГАУЗ «Родильный дом им. Семашко»',
      'ОГАУЗ «Стоматологическая поликлиника»',
      'ОГАУЗ «Стрежевская городская больница»',
      'ОГАУЗ «Томская областная клиническая больница»',
      'ОГАУЗ «Томский областной онкологический диспансер»',
      'ОГБУЗ «Асиновская районная больница»',
      'ОГБУЗ «Бакчарская районная больница»',
      'ОГБУЗ «Верхнекетская районная больница»',
      'ОГБУЗ «Детская стоматологическая поликлиника №1»',
      'ОГБУЗ «Детская стоматологическая поликлиника №2»',
      'ОГБУЗ «Зырянская районная больница»',
      'ОГБУЗ «Каргасокская районная больница»',
      'ОГБУЗ «Кожевниковская районная больница»',
      'ОГБУЗ «Колпашевская районная больница»',
      'ОГБУЗ «Кривошеинская районная больница»',
      'ОГБУЗ «Лоскутовская районная поликлиника»',
      'ОГБУЗ «Медико-санитарная часть №2»',
      'ОГБУЗ «Молчановская районная больница»',
      'ОГБУЗ «Моряковская участковая больница»',
      'ОГБУЗ «МСЧ №1»',
      'ОГБУЗ «Областная детская больница»',
      'ОГБУЗ «Парабельская районная больница»',
      'ОГБУЗ «Первомайская районная больница»',
      'ОГБУЗ «Родильный дом №1»',
      'ОГБУЗ «Светленская районная больница»',
      'ОГБУЗ «Стоматологическая поликлиника №1»',
      'ОГБУЗ «Тегульдетская районная больница»',
      'ОГБУЗ «Томская клиническая психиатрическая больница»',
      'ОГБУЗ «Томская районная больница»',
      'ОГБУЗ «Томский областной кожно-венерологический диспансер»',
      'ОГБУЗ «Томский областной центр по профилактике и борьбе со СПИД»',
      'ОГБУЗ «Томский фтизиопульмонологический медицинский центр»',
      'ОГБУЗ «Чаинская районная больница»',
      'ОГБУЗ «Шегарская районная больница»',
    ]
  end

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
#  username      :text
#
