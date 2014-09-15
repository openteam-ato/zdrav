class ThanksController < MainController
  layout 'public'

  def index
    render :file => "#{Rails.root}/public/404", :formats => [:html], :layout => false and return if request_status == 404

    page_regions.each do |region|
      eval "@#{region} = page.regions.#{region}"
    end

    @thanks = Thank.published

    @page_title = page.title
    @page_meta = page.meta
    @link_to_json = remote_url
  end
end
