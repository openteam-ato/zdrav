class Manage::DoctorsController < Manage::ApplicationController

  inherit_resources

  def update
    update! do |format|
      resource.photo = nil if params['doctor'].try(:[], 'delete_photo') == 'true'
      resource.save
    end
  end

end
