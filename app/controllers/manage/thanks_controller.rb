class Manage::ThanksController < Manage::ApplicationController
  inherit_resources
  has_scope :by_state, :only => :index, :default => 'draft'

  actions :all, :except => :show
  custom_actions :resource => :change

  def change
    change!{
      @thank.change!

      render @thank and return
    }
  end
end
