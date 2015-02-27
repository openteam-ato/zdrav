class AddRequestInfoToEvaluationRegistries < ActiveRecord::Migration
  def change
    add_column :evaluation_registries, :ip, :text
    add_column :evaluation_registries, :user_agent, :text
  end
end
