class Manage::ThanksController < Manage::ApplicationController
  inherit_resources

  has_scope :ordered, :default => 1, :only => :index

  actions :all, :except => :show

  custom_actions :resource => :change

  def index
    index! { @thanks = Kaminari.paginate_array(collection).page(params[:page]).per(10) }
  end

  def create
    create! do
      published_at = Time.now if published_at.blank?
      super and return
    end
  end

  def change
    change!{
      @thank.change!

      render @thank and return
    }
  end
end
