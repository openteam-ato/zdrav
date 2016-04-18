class AddDeleteReasonToVideoMessage < ActiveRecord::Migration
  def change
    add_column :video_messages, :delete_reason, :text
  end
end
