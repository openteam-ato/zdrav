class AddAttachmentToEvaluationRegistryAttachments < ActiveRecord::Migration
  def self.up
    add_attachment :evaluation_registry_attachments, :attachment
    add_column :evaluation_registry_attachments, :attachment_meta, :text
  end

  def self.down
    remove_attachment :evaluation_registry_attachments, :attachment
    remove_column :evaluation_registry_attachments, :attachment_meta
  end
end
