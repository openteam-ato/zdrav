class EvaluationRegistriesXls
  attr_accessor :evaluation_registries

  def initialize(evaluation_registries)
    @evaluation_registries = evaluation_registries
  end

  def xls
    set_headers
    set_rows

    string_data
  end

  private

  def book
    @book ||= Spreadsheet::Workbook.new
  end

  def sheet
    @sheet ||= book.create_worksheet :name => 'Список анкет'
  end

  def fields
    %W[title ip user_agent
       question_1_1 question_1_2 question_1_3 question_1_4 question_1_5 question_1_6
       question_1_7 question_1_8 question_1_9 question_1_10 question_1_11
       question_2_1 question_2_2 question_2_3 question_2_4 question_2_5 question_2_6
       question_2_7 question_2_8 question_2_9
       question_3_1 question_3_2 question_3_3 question_3_4 question_3_5 question_3_6
       question_4_1 question_4_2 question_4_3 question_5_1 question_5_2 proposal]
  end

  def headers
    [].tap do |headers|
      fields.each do |field|
        headers << I18n.t("activerecord.attributes.evaluation_registry.#{field}")
      end
    end
  end

  def rows
    rows = []

    evaluation_registries.each do |er|
      rows << [].tap do |row|
        fields.each do |field|
          row << er.send(field)
        end
      end
    end

    rows
  end

  def set_headers
    sheet.row(0).concat headers
  end

  def set_rows
    rows.each_with_index { |row, index| sheet.row(index + 1).concat row }
  end

  def string_data
    string_io = StringIO.new
    book.write string_io

    string_io.string
  end
end
