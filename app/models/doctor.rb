class Doctor < ActiveRecord::Base

  include RemoteIndex

  after_save :reindex

  attr_accessor :delete_photo

  attr_accessible :name, :post, :photo, :description, :delete_photo

  before_validation { photo.clear if delete_photo == 'true' }

  validates :name, :presence => true, :uniqueness => true

  has_attached_file :photo, :storage => :elvfs, :elvfs_url => Settings['storage.url']
  validates_attachment_content_type :photo, :content_type => ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  scope :ordered, -> (_) { order('name') }

  normalize_attributes :name, :post
  normalize_attribute :description, :with => [:strip_empty_html, :strip, :blank]

  extend FriendlyId
  friendly_id :name, :use => :slugged

end

# == Schema Information
#
# Table name: doctors
#
#  id                 :integer          not null, primary key
#  name               :text
#  post               :text
#  description        :text
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  photo_url          :text
#  photo_meta         :text
#  slug               :string
#
