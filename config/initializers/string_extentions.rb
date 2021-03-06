require 'russian'

class String

  def as_html
    self.to_s.gsub(/&(laquo|raquo|quot);/, '"').gilensize.html_safe
  end

  def slugged
    Russian::transliterate(self.to_s).downcase.gsub(/\s+/, '-').gsub(/«|»|,|\./, '').gsub(/-+/, '-')
  end

end
