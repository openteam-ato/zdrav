class AddAttachmentAnswerSourceToVideoMessages < ActiveRecord::Migration
  def self.up
    change_table :video_messages do |t|
      t.attachment :answer_source
    end
  end

  def self.down
    remove_attachment :video_messages, :answer_source
  end
end
