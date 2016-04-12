class AddAttachmentQuestionConvertedToVideoMessages < ActiveRecord::Migration
  def self.up
    change_table :video_messages do |t|
      t.attachment :question_converted
    end
  end

  def self.down
    remove_attachment :video_messages, :question_converted
  end
end
