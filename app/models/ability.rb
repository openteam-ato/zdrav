class Ability
  include CanCan::Ability

  def initialize(user, namespace = nil)
    return unless user


    case namespace
    when 'manage'
      can :manage, :all if user.manager?

    when 'eco'
      can :manage, :all if user.operator?
    end

    can :manage, :all if user.admin?
  end
end
