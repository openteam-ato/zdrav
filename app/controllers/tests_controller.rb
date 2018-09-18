class TestsController < MainController
  before_action :prepare_cms
  before_action :set_questions, only: [:edit, :update]

  def authorize_entry; end

  def edit
    @claim = Claim.find_by claim_params

    unless @claim
      flash[:alert] = 'Вы ввели неверные данные!'
      render 'authorize_entry'
    end
  end

  def update
    @claim = Claim.find_by id: params[:test][:claim_id]
    test_result = TestResult.find_by id: params[:test][:test_result_id]
    answers = params[:test][:questions]

    if test_result.update(answers: answers)
      flash[:success] = 'Результаты успешно сохранены'
    else
      flash[:alert] = 'Ошибка сохранения, попробуйте сохранить результат еще раз.'
    end

    render 'edit'
  end

  private

  def claim_params
    params.require(:claim).permit(:authorize_token, :email)
  end

  def set_questions
    file = YAML.load_file('data/tests/personal_control.yml')
    @questions = file['questions']
  end
end
