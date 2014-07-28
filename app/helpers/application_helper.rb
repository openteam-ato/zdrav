# encoding: utf-8

module ApplicationHelper
  def render_navigation(hash)
    return '' if hash.nil? || hash.empty?
    content_tag :ul do
      hash.map do |key, value|
        content_tag :li, :class => value['selected'] ? 'selected' : nil do
          render_link_for_navigation(value) + render_navigation(value['children'])
        end
      end.join.html_safe
    end
  end

  def render_link_for_navigation(item)
    if item['external_link'].present?
      link_to item['title'], item['external_link'], :target => :_blank
    else
      link_to item['title'], item['path']
    end
  end

  def render_partial_for_region(region, prefix = nil)
    if region && (region.response_status == 200 || !region.response_status?)
      template = prefix.present? ? "#{prefix}_#{region.template}" : region.template
      render :partial => "regions/#{template}",
      :locals => { :object => region.content, :response_status => region.response_status }
    else
      render :partial => 'regions/error', :locals => { :region => region }
    end
  end

  def interval_for(event)
    since_date, since_time = l(event.since.to_datetime, :format => '%d.%B.%Y %H:%M').split(' ')
    until_date, until_time = l(event.until.to_datetime, :format => '%d.%B.%Y %H:%M').split(' ')

    since_date.gsub!(".", " ")
    since_date.gsub!(" #{Date.today.year}", "")
    until_date.gsub!('.', ' ')
    until_date.gsub!(" #{Date.today.year}", "")

    since_arr = []
    until_arr = []

    since_arr << content_tag(:span, since_date, :class => 'nobr')
    until_arr << content_tag(:span, until_date, :class => 'nobr') if since_date != until_date


    if since_time != '00:00'
      since_arr << ", #{since_time}"
      if until_time != '00:00' && until_time != '23:59'
        if since_time != until_time
          if until_arr.empty?
            until_arr << until_time
          else
            until_arr << ", #{until_time}"
          end
        else
          unless until_arr.empty?
            until_arr << ", #{until_time}"
          end
        end
      end
    else
      if until_time != '00:00' && until_time != '23:59'
        unless until_arr.empty?
          until_arr << ", #{until_time}"
        end
      end
    end

    res = since_arr.join

    unless until_arr.empty?
      res += ' &ndash; '
      res += until_arr.join
    end

    res.html_safe

  end

  def entry_date
    @entry_date ||= begin
                      @page.regions.to_hash.each do |region_name, region|
                        if (since = region.try(:[], 'content').try(:[], 'since'))
                          return since
                        end
                      end
                      nil
                    end
  end

  def entries_rss_link(parts_array)
    part = parts_array.compact.select { |part| part.content.rss_link }.first
    part.content.rss_link if part
  end

  def render_empty_message(parts_array)
    parts_array = parts_array.compact.select { |part| part.content.items && part.content.items.any? }
    return "" if parts_array.any?
    content_tag :p, "Нет актуальной информации"
  end

  def archive_links(parts_array)
    parts_array = parts_array.compact.select { |part| part.content.items }

    return "" if parts_array.empty?
    @events = parts_array.map(&:archive_dates)

    base_path = parts_array.first.content.collection_link

    list_type = parts_array.first.type.underscore.gsub!('_part', '')

    result = '<ul>'

    current_year = params[:parts_params].try(:[], list_type).try(:[], "interval_year")
    current_month = params[:parts_params].try(:[], list_type).try(:[], "interval_month")

    return "" if archive_monthes.size < 2

    monthes_by_year.each do |year, dates|
      result += '<li>'
      result += link_to(year, '#', :class => "year#{current_year == year.to_s ? ' active' : nil}")
      result += '<ul>'
      result += dates.map{ |date| content_tag(:li, link_to(t('date.month_names')[date.month], "#{base_path}/?parts_params[#{list_type}][interval_year]=#{year}&parts_params[#{list_type}][interval_month]=#{date.month}", :class => current_month == date.month.to_s && current_year == year.to_s ? 'active' : nil)) }.join('')
      result += '</ul></li>'
    end

    result += '</ul>'

    result.html_safe
  end

  def archive_monthes
    (early_date..lately_date).select{|m| m.day == 1 }
  end

  def monthes_by_year
    archive_monthes.reverse.group_by(&:year)
  end

  def early_date
    @events.map(&:min_date).map(&:to_date).min.strftime('01-%B-%Y').to_date
  end

  def lately_date
    @events.map(&:max_date).map(&:to_date).max
  end

  def get_link(navigation, object)
    link = navigation.to_hash.to_s.match(/#{object.title.squish}\", \"path\"=>\"(.*?)\"/).try(:[], 1)
    external_link = navigation.to_hash.to_s.match(/#{object.title.squish}\",.*?\"external_link\"=>\"(.*?)\"/).try(:[], 1)

    return render_link_for_navigation({ 'title' => object.title, 'path' => link, 'external_link' => external_link }) if link

    return object.title
  end

  def extension(filename)
    return if filename.blank?
    filename.match(/\.(\w+)$/).try(:[], 1).downcase
  end
end
