class TestResult < ActiveRecord::Base
  belongs_to :claim

  serialize :answers, Hash

  before_save :check_right_answers

  def check_right_answers
    self.right_answers = test_file['questions'].map.with_index do |question, index|
      question if answers["#{index}"] == question['right'].to_s
    end.compact.count
  end

  def question_count
    test_file['questions'].count
  end

  private

  def test_file
    YAML.load_file('data/tests/personal_control_full.yml')
  end
end
