class TestResult < ActiveRecord::Base
  belongs_to :claim

  serialize :answers, Hash

  before_save :check_right_answers

  def check_right_answers
    file = YAML.load_file('data/tests/personal_control.yml')

    self.right_answers = file['questions'].map.with_index do |question, index|
      question if answers["#{index}"] == question['right'].to_s
    end.compact.count
  end
end
