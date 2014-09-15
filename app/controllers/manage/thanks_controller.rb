class Manage::ThanksController < Manage::ApplicationController
  inherit_resources

  actions :all, :except => :show
end
