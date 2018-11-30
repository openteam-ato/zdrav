class HumanReservClaim < ActiveRecord::Base
  extend Enumerize

  validates :fullname, :old_post, :old_organization, :reserv_date, :reserv_level, presence: true

  enumerize :reserv_level, in: [:basic, :middle, :high]
end
