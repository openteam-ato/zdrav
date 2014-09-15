class Thank < ActiveRecord::Base
  attr_accessible :email, :fullname, :message, :state

  extend Enumerize
  enumerize :state, :in => [:draft, :published], :default => :draft, :predicates => true

  scope :published, where(:state => :published)
end
