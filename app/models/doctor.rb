class Doctor < ActiveRecord::Base
  attr_accessible :name, :post, :photo, :description

  validates :name, :presence => true, :uniqueness => true

  has_attached_file :photo, :storage => :elvfs, :elvfs_url => Settings['storage.url']
  validates_attachment_content_type :photo, :content_type => ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  scope :ordered, -> (_) { order('name') }

  normalize_attributes :name, :post
  normalize_attribute :description, :with => [:strip_empty_html, :strip, :blank]
end

# == Schema Information
#
# Table name: doctors
#
#  id                 :integer          not null, primary key
#  name               :text
#  post               :text
#  description        :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  photo_url          :text
#  photo_meta         :text
#
