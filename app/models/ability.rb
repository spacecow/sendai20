class Ability
  include CanCan::Ability

  def initialize(user)
    can [:create,:reset_password,:update_password], User
    can :create, Reset
    
    if user
      if user.role? :god
        can :manage, :all
      else
        if user.role?(:member) || user.role?(:mini_admin) || user.role?(:admin)
          can :update, User, :id => user.id
          can :show, User
          can :create, Opinion
          can :update, Opinion, :user_id => user.id
        end
        if user.role?(:mini_admin) || user.role?(:admin)
          can :index, User
          can :update, User
        end
        if user.role? :admin
          can [:edit_roles, :update_roles, :destroy], User
          can [:update], Opinion
          can [:create,:update], Locale
          can [:index,:create,:delete], Translation
        end
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
