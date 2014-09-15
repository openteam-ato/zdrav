class ThanksController < ApplicationController
  inherit_resources

  layout 'public'

  actions :index

  def index
    index!{
      @page_title = 'foo'
      @site_name = 'bar'
    }
  end
end
