class AddAttachmentsToVideoMessages < ActiveRecord::Migration
  def self.up
    add_attachment :video_messages, :question_source
    add_column :video_messages, :question_source_fingerprint, :string

    add_attachment :video_messages, :question_converted
    add_column :video_messages, :question_converted_fingerprint, :string

    add_attachment :video_messages, :answer_source
    add_column :video_messages, :answer_source_fingerprint, :string

    add_attachment :video_messages, :answer_converted
    add_column :video_messages, :answer_converted_fingerprint, :string
  end

  def self.down
    remove_column :video_messages, :answer_converted_fingerprint
    remove_attachment :video_messages, :answer_converted

    remove_column :video_messages, :answer_source_fingerprint
    remove_attachment :video_messages, :answer_source

    remove_column :video_messages, :question_converted_fingerprint
    remove_attachment :video_messages, :question_converted

    remove_column :video_messages, :question_source_fingerprint
    remove_attachment :video_messages, :question_source
  end
end
