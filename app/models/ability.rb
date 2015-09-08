class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :application do
      user.manager?
    end

    can :manage, :all do
      user.admin?
    end

    # TODO: insert app specific rules here
  end
end
