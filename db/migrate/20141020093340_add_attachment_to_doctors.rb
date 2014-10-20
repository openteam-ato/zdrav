class AddAttachmentToDoctors < ActiveRecord::Migration
  def self.up
    add_attachment :doctors, :photo
    add_column :doctors, :photo_meta, :text
  end

  def self.down
    remove_attachment :doctors, :photo
    remove_column :doctors, :photo_meta
  end
end
