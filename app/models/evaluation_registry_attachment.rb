class EvaluationRegistryAttachment < ActiveRecord::Base
  attr_accessible :attachment

  belongs_to :evaluation_registry

  validates_presence_of :attachment

  has_attached_file :attachment, :storage => :elvfs, :elvfs_url => Settings['storage.url']
  do_not_validate_attachment_file_type :attachment
end

# == Schema Information
#
# Table name: evaluation_registry_attachments
#
#  id                      :integer          not null, primary key
#  evaluation_registry_id  :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  attachment_url          :text
#  attachment_meta         :text
#
