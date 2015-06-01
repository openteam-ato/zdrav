class AddRequestInfoToThanks < ActiveRecord::Migration
  def change
    add_column :thanks, :ip, :text
    add_column :thanks, :user_agent, :text
  end
end
