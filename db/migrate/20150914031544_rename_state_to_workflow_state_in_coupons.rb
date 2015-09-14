class RenameStateToWorkflowStateInCoupons < ActiveRecord::Migration
  def change
    rename_column :coupons, :state, :workflow_state
  end
end
