class Thank < ActiveRecord::Base
  attr_accessible :email, :fullname, :message, :state

  extend Enumerize
  enumerize :state, :in => [:draft, :published], :default => :draft, :predicates => true

  scope :by_state, ->(state) { where(:state => state).ordered }
  scope :ordered,   ->{ order('created_at desc') }
  scope :published, by_state(:published)

  validates_presence_of :fullname, :message

  def change!
    self.state = (state.draft? ? :published : :draft)
    self.save
  end
end
