class AddAttachmentQuestionSourceToVideoMessages < ActiveRecord::Migration
  def self.up
    change_table :video_messages do |t|
      t.attachment :question_source
    end
  end

  def self.down
    remove_attachment :video_messages, :question_source
  end
end
