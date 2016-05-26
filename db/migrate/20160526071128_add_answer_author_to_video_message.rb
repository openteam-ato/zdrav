class AddAnswerAuthorToVideoMessage < ActiveRecord::Migration
  def change
    add_column :video_messages, :answer_author, :string
    add_column :video_messages, :answer_author_post, :text
  end
end
