class Ability
  include CanCan::Ability

  def initialize(user, namespace = nil)
    return unless user

    case namespace
    when nil
      can :manage, :application do
        user.manager?
      end

      can :manage, :all do
        user.admin?
      end

    when 'eco'
      can :manage, :all do
        user.permissions.any?
      end
    end
  end
end
