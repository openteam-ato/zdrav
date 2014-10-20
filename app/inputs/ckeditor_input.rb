class CkeditorInput < SimpleForm::Inputs::TextInput
  def input(wrapper_options = nil)
    @builder.text_area(attribute_name, input_html_options.merge!(:class => 'ckeditor form-control'))
  end
end
