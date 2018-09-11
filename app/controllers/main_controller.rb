class MainController < ApplicationController

  helper_method :cms_address

  before_filter :prepare_cms, :only => [:index, :new]

  before_filter :detect_robots_in_development if Rails.env.development?

  def index
    render "templates/#{page.template}"
  end

  private

  def detect_robots_in_development
    puts "\n\n"
    puts "DEBUG ---> #{request.user_agent.to_s}"
    puts "Params: #{params}"
    puts "\n\n"

    render :nothing => true, status: :forbidden and return if request.user_agent.to_s.match(/\(.*https?:\/\/.*\)/)
  end

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
    original_request_path, parts_params = request.fullpath.split('?')
    request_path = original_request_path
    [
      '/ru/zdravoohranenie-v-tomskoy-oblasti/spetsialistam/zemskiy-doktor/uchastniki',
      '/ru/dlya-naseleniya/obrascheniya-grazhdan/blagodarnosti-patsientov',
      '/ru/konkurs-poliklinika-nachinaetsya-s-registratury/otvetit-na-voprosy-ankety',
      '/ru/thanks',
      '/ru/zdravoohranenie-v-tomskoy-oblasti/otraslevoe-razvitie/formirovanie-patsient-orientirovannoy-sistemy-zdravoohraneniya-v-tomskoy-oblasti',
      '/ru/anketa-samodiagnostiki-serdechno-sosudistyh-zabolevaniy',
      '/ru/dlya-naseleniya/otslezhivanie-ocheredi-eko',
      '/ru/dlya-naseleniya/obrascheniya-grazhdan/videoobrascheniya-v-departament/otpravit-videoobraschenie-v-departament',
      '/ru/dlya-naseleniya/obrascheniya-grazhdan/videoobrascheniya-v-departament/spisok-videoobrascheniy',
      '/ru/departament/ruk_zdrav/podtverjdenie_emaila',
      '/ru/departament/ruk_zdrav/povtornoe_podtverjdenie_emaila',
      '/ru/departament/ruk_zdrav/novaya_zayavka'
    ].each do |path|
      request_path = path if original_request_path.match(/\A#{path}.*/)
    end

    if original_request_path == '/ru/dlya-naseleniya/obrascheniya-grazhdan/videoobrascheniya-v-departament/otpravit-videoobraschenie-v-departament/done'
      request_path = '/ru/dlya-naseleniya/obrascheniya-grazhdan/videoobrascheniya-v-departament/otpravit-videoobraschenie-v-departament/done'
    end

    if original_request_path == '/ru/konkurs-poliklinika-nachinaetsya-s-registratury/otvetit-na-voprosy-ankety/done'
      request_path = '/ru/konkurs-poliklinika-nachinaetsya-s-registratury/otvetit-na-voprosy-ankety/done'
    end

    if original_request_path.match(/\/podderzhat-deklaraciyu\/done/)
      request_path = '/ru/zdravoohranenie-v-tomskoy-oblasti/otraslevoe-razvitie/formirovanie-patsient-orientirovannoy-sistemy-zdravoohraneniya-v-tomskoy-oblasti/podderzhat-deklaratsiyu/done'
		end

    if original_request_path.match(/^\/[manage|eco]/)
      request_path = '/ru'
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
