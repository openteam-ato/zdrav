class AddAttachmentAnswerConvertedToVideoMessages < ActiveRecord::Migration
  def self.up
    change_table :video_messages do |t|
      t.attachment :answer_converted
    end
  end

  def self.down
    remove_attachment :video_messages, :answer_converted
  end
end
