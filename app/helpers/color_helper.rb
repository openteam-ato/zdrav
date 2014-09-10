# encoding: utf-8

module ColorHelper

  def header_css_class
    case request.fullpath.split('?').first.to_s.split('/').delete_if(&:blank?).second
    when 'departament'
      'green'
    when 'zdravoohranenie-v-tomskoy-oblasti'
      'yellow'
    else
      'purple'
    end
  end

end
