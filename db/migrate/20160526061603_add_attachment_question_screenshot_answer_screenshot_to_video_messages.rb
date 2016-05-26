class AddAttachmentQuestionScreenshotAnswerScreenshotToVideoMessages < ActiveRecord::Migration
  def self.up
    change_table :video_messages do |t|
      t.attachment :question_screenshot
      t.attachment :answer_screenshot
    end
  end

  def self.down
    remove_attachment :video_messages, :question_screenshot
    remove_attachment :video_messages, :answer_screenshot
  end
end
