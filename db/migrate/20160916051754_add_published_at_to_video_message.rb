class AddPublishedAtToVideoMessage < ActiveRecord::Migration
  def up
    add_column :video_messages, :published_at, :datetime
    VideoMessage.find_each { |video| video.update_attribute :published_at, video.updated_at }
  end

  def down
    remove_column :video_messages, :published_at
  end
end
