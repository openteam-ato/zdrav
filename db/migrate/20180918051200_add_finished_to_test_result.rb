class AddFinishedToTestResult < ActiveRecord::Migration
  def change
    add_column :test_results, :finished, :boolean, default: false
  end
end
