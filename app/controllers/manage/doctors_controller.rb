class Manage::DoctorsController < Manage::ApplicationController

  inherit_resources

  has_scope :ordered, :default => 1, :only => :index

  def index
    index! { @doctors = Kaminari.paginate_array(collection).page(params[:page]).per(5) }
  end

  def update
    update! do |format|
      resource.photo = nil if params['doctor'].try(:[], 'delete_photo') == 'true'
      resource.save
    end
  end

end
