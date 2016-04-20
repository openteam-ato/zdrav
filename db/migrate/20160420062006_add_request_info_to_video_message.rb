class AddRequestInfoToVideoMessage < ActiveRecord::Migration
  def change
    add_column :video_messages, :ip, :text
    add_column :video_messages, :user_agent, :text
  end
end
