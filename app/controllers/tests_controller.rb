class TestsController < MainController
  before_action :prepare_cms
  before_action :set_questions, only: [:edit, :update, :finish]
  before_action :set_test_results, only: [:update, :finish]

  def authorize_entry; end

  def edit
    @claim = Claim.find_by email: params['claim']['email'].squish.downcase,
                           authorize_token: params['claim']['authorize_token']

    @claim.present? ? (flash['alert'] = nil) : raise('error')
  rescue
    flash[:alert] = 'Вы ввели неверные данные!'
    render 'authorize_entry'
  end

  def update
    @test_result.update answers: params[:test][:questions]
    flash[:alert] = 'Результаты теста успешно сохранены'

    render 'edit'
  end

  def finish
    answers = params[:test][:questions]
    @test_result.update answers: answers

    question_without_answer = @questions.map.with_index do |question, index|
      index + 1 unless answers["#{index}"]
    end.compact

    if question_without_answer.present?
      flash[:alert] = "Вы не ответили на вопросы под номерами: #{question_without_answer.join(', ')}"
    else
      @test_result.update_attribute(:finished, true)

      ClaimsMailer.delay(retry: false).test_results_email(@claim.email, @test_result.right_answers, @questions.count)
    end

    render 'edit'
  end

  private

  def set_questions
    file = YAML.load_file('data/tests/personal_control_full.yml')
    @questions = file['questions']
  end

  def set_test_results
    @claim = Claim.find_by id: params[:test][:claim_id]
    @test_result = TestResult.find_by id: params[:test][:test_result_id]
  end
end
