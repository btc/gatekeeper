class Ability
  include CanCan::Ability

  def initialize(user)
    # WARNING!
    # ========
    # Do not attempt to use the line below. Users who are not logged in
    # should not have access to any functions inside the application.
    # user ||= User.new # guest user (not logged in)
    # - brianhc

    can :go, :home # every logged in user can go home

    can :upload_webcam, Photo #temp to take webcam photo TODO fix

    # all users can view guests;
    # attribute-specific permissions are handled at view-level
    can :read, Guest
    can :create, Guest # all users can create guests

    can :update, Guest do |guest|
      true # anyone can update
      # guest.creator == user
    end

    can :view_contact_info, Guest
    can :view_photos, Guest

    # GUEST LIST PERMISSIONS
    # ======================
    can :manage, GuestList # FIXME TODO restrict by role
    can :manage, Invitation # FIXME TODO restrict by role
    can :lookup_names, Guest # any user full_name_search always

=begin
    if user.role? :boss
      can :rate, Guest
      can :view_contact_info, Guest
      can :view_photos, Guest
      can :view_rating, Guest
      can :update_rating, Guest
    end
=end

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
