class MainController < ApplicationController

  helper_method :cms_address

  before_filter :prepare_cms, :only => [:index, :new]

  def index
    respond_to  do |format|
      format.html { render "templates/#{page.template}" }
    end
  end

  private
    def prepare_cms
      render :file => "#{Rails.root}/public/404", :formats => [:html], :layout => false, :status => 404 and return if request_status == 404

      page_regions.each do |region|
        eval "@#{region} = page.regions.#{region}"
      end

      @page_title = page.title
      @page_meta = page.meta
      @link_to_json = remote_url
    end

    def cms_address
      "#{Settings['cms.url']}/nodes/#{Settings['cms.site_slug']}"
    end

    def remote_url
      request_path, parts_params = request.fullpath.split('?')
      [
        '/ru/zdravoohranenie-v-tomskoy-oblasti/spetsialistam/zemskiy-doktor/uchastniki',
        '/ru/dlya-naseleniya/obrascheniya-grazhdan/blagodarnosti-patsientov',
        '/ru/konkurs-poliklinika-nachinaetsya-s-registratury/otvetit-na-voprosy-ankety',
        '/ru/thanks'
      ].each do |path|
        request_path = path if request_path.match(/\A#{path}.*/)
      end

      ["#{cms_address}#{request_path.split('/').compact.join('/')}.json", parts_params].compact.join('?')
    end

    def page
      @page ||= Hashie::Mash.new(request_json).page
    end

    def curl_request
      @curl_request ||= Curl::Easy.perform(remote_url) do |curl|
        curl.headers['Accept'] = 'application/json'
      end
    end

    def request_status
      @request_status ||= curl_request.response_code
    end

    def request_body
      @request_body ||= curl_request.body_str
    end

    def is_json?(str)
      begin
        !!JSON.parse(str)
      rescue
        false
      end
    end

    def request_json
      @request_json ||= begin
                          raise ActionController::RoutingError.new('Not Found') unless is_json?(request_body)
                          ActiveSupport::JSON.decode(request_body)
                        end
    end

    def page_regions
      @page_regions ||= page.regions.keys
    end

end
