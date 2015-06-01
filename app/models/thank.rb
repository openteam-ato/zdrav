class Thank < ActiveRecord::Base

  attr_accessible :email, :fullname, :message, :state, :published_at, :ip, :user_agent

  extend Enumerize
  enumerize :state, :in => [:draft, :published], :default => :draft, :predicates => true

  scope :by_state, -> (state) { where(:state => state).ordered(1) }
  scope :ordered, -> (_) { order('published_at desc') }
  scope :published, by_state(:published)
  scope :draft, by_state(:draft)

  validates_presence_of :fullname, :message

  default_value_for :published_at do
    Time.now
  end

  default_value_for :key do
    UUID.new.generate
  end

  normalize_attributes :email, :fullname, :message

  def change!
    self.state = (state.draft? ? :published : :draft)
    self.save
  end
end

# == Schema Information
#
# Table name: thanks
#
#  id           :integer          not null, primary key
#  fullname     :string(255)
#  email        :string(255)
#  message      :text
#  state        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  published_at :datetime
#  key          :string(255)
#  ip           :text
#  user_agent   :text
#
