class Ability
  include CanCan::Ability

  def initialize(user)
    # WARNING!
    # ========
    # Do not attempt to use the line below. Users who are not logged in
    # should not have access to any functions inside the application.
    # user ||= User.new # guest user (not logged in)
    # - brianhc

    # GENERAL INFO
    # ============
    # By default, users do not have access to any resources.
    # All permissions must be explicitly defined
    # for one of the documented, predefined roles.
    # The one exception to this rule:
    # all users
    can :go, :home


    # if user.has_role? :committee_member
    #   can :update_plus, GuestList do |guest_list|
    #     guest_list.creator == user && guest_list.approved == false
    #   end
    # end

    # Door attendants
    # ===============
    # ===============
    if user.has_role? :door_attendant

      # managing GuestLists
      # -------------------
      cannot :destroy, GuestList
      can :read, GuestList do |list|
        list.approved? && list.date == Nightclub.today
      end
      can :view_all_listings_view, GuestList
      can :read, Guest
      can :read, Invitation do |i|
        i.guest_list.approved?
      end
      # only the redeemed field
      # must enforce at view level
      can :update, Invitation
      can :check_in_guest, Invitation

      # view-specific permissions
      # -------------------------
      can :view_contact_info, Guest
      can :view_photos, Guest

      # creating Guests
      # ---------------
      can :upload_webcam, Photo #temp to take webcam photo TODO fix
      can :create, Guest # needed when guests arrive at the door
      can :update, Guest # to enrich profiles with new information
      cannot :destroy, Guest

      # creating Guests
      # ---------------
      can :create, Note
      # GUEST LIST PERMISSIONS
      # ======================
      # can :update_plus, GuestList # managers and admins
      # can :manage, GuestList # FIXME TODO restrict by role
      # can :manage, Invitation # FIXME TODO restrict by role
      # can :lookup_names, Guest # any user full_name_search always
    end

    if user.has_role? :committee_member
      can :read, GuestList do |list|
        list.creator == user
      end
      can :destroy, GuestList do |list|
        list.creator == user
      end
      can :update, Invitation do |i|
        g = i.guest_list
        if g.present? && g.creator == user && g.approved == false
        end
      end
      can :edit_date, GuestList do |list|
        list.creator == user
      end
      can :destroy, Invitation
      can :tag, Invitation
      can :create, Guest
      can :lookup_names, Guest
      can :create, GuestList
    end

    if user.email == 'czora12@gmail.com' || user.email == 'brian.holderchow@gmail.com'
      can :manage, Role
    end

    # Admins
    # ======
    # ======
    # can manage and view everything
    # make sure to keep this at the bottom so it can override all rules
    if user.has_role?(:admin) || user.has_role?(:manager)
      can :manage, :all
    end

  end
end
