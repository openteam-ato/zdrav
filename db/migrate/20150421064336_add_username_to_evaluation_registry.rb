class AddUsernameToEvaluationRegistry < ActiveRecord::Migration
  def change
    add_column :evaluation_registries, :username, :text
  end
end
