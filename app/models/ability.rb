class Ability
  include CanCan::Ability

  def initialize(user)
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
    alias_action :edit, :to => :update
    unless user.nil?
      if user.admin?
        can :manage, :all
        return
      end

      can :update, :profile do |profile|
        profile.try(:user) == user
      end

      unless user.profile.nil?
        can :create, Club
        can :manage, Club do |club|
          club.memberships.where(:profile_id => user.profile, :role_level => 0 ).exists? and club.audited?
        end
        can :manage_dashboard, Club do |club|
          club.memberships.where(:profile_id => user.profile, :role_level => 0..9 ).exists? and club.audited?
        end
      end
    end
    can :read, :all
  end
end
