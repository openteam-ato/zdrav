# encoding: utf-8

class String

  def slugged
    Russian::transliterate(self).downcase.gsub(/\s+/, '-').gsub(/«|»/, '')
  end

end
