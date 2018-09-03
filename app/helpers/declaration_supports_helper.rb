module DeclarationSupportsHelper
  def declaration_support_dynamic_counter(number)
    current_number = "%03d" % number
    format_number = current_number.split('').map do |n|
      content_tag(:div, n, class: 'cute-counter-number')
    end

    format_number
  end
end
