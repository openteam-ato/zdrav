class DeclarationSupportsController < MainController
  before_filter :prepare_cms

  def index
    @declaration_supports = DeclarationSupport.approved
  end

  def new
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

    @declaration_support = DeclarationSupport.new
  end

  def create
    @declaration_support = DeclarationSupport.new(declaration_support_params)

    if verify_recaptcha(model: @declaration_support)
      if @declaration_support.save
        DeclarationSupportsMailer.delay(retry: false).new_declaration_support_email(@declaration_support)
        redirect_to show_declaration_support_path
      else
        render 'new'
      end
    else
      render 'new'
    end
  end

  private

  def declaration_support_params
    params.require(:declaration_support).permit(:name, :surname, :patronymic, :job, :email, :agreement)
  end
end
