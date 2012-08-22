class Ability
  include CanCan::Ability

  def initialize(user)
    # WARNING!
    # ========
    # Do not attempt to use the line below. Users who are not logged in
    # should not have access to any functions inside the application.
    # user ||= User.new # guest user (not logged in)
    # - brianhc

    # every logged in user can go home
    can :go, :home
    # all users can create guests
    can :create, Guest

    # QUICK DOCUMENTATION
    # ===================
    # first argument to can (action)
    # :read, :create, :update and :destroy, :manage
    #
    # The second argument (resource)
    # :all it will apply to every resource.
    # Otherwise pass a Ruby class of the resource.
    #
    # third argument (is an optional hash of conditions)
    # For example, here the user can only update published articles.
    # can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
