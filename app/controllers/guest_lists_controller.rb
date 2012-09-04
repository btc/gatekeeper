require 'chronic'

class GuestListsController < ApplicationController
  load_and_authorize_resource except: [:form, :search]

  # GET /guest_lists
  # GET /guest_lists.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { respond_with_bip @guest_lists }
    end
  end

  # GET /guest_lists/1
  # GET /guest_lists/1.json
  def show
    @guest_list = GuestList.includes( { invitations: :guest },
                                      :owner).find(params[:id])
    @guest_list.invitations.sort_by! do |i|
      i.guest.try(:full_name)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { respond_with_bip @guest_list }
    end
  end

  # GET /guest_lists/new
  # GET /guest_lists/new.json
  def new
    @guest_list = GuestList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { respond_with_bip @guest_list }
    end
  end

  # GET /guest_lists/1/edit
  def edit
    @guest_list = GuestList.find(params[:id])
  end

  # POST /guest_lists
  # POST /guest_lists.json
  def create
    @guest_list = GuestList.new(params[:guest_list])
    @guest_list.creator = current_user

    if params[:q].nil? || params[:q].empty?
      flash[:alert] = 'please select at least one guest'
    else
      # pre-process the comma-separated ids
      guest_ids = params[:q].split(',')

      # set the owner
      owner_id = guest_ids[0] # semantically, 1st id represents owner
      owner = Guest.find_by_id owner_id
      if owner.nil?
        # invalid id was passed in with request
        flash[:alert] = 'primary guest not found. please try again'
        render action: :new and return
      end
      @guest_list.owner = owner

      # for all specified guests
      @guests = []
      guest_ids.each do |guest_id|
        guest = Guest.find_by_id(guest_id)
        @guests << guest
        if guest.present?
          # create invitation
          invitation = @guest_list.invitations.build
          invitation.guest = guest
        end
      end
      @guest_list.invitations.sort_by! { |i| i.guest.first_name }
    end

    # ensure date is present and apply it
    raw_date = params[:guest_list][:date]
    if (raw_date.nil? || raw_date.empty?) && @guest_list.date.nil?
      flash[:alert] ||= 'please enter a date'
    else
      @guest_list.update_attribute :date, raw_date
    end

    respond_to do |format|
      if @guest_list.save
        format.html { redirect_to @guest_list, notice: 'Hui! Guest list was successfully created.' }
        format.json { respond_with_bip @guest_list }
      else
        format.html do
          # pass data to pre-populate list upon failure
          @saved_selections = Guest.id_name_tuples @guests
          render action: "new"
        end
        format.json { respond_with_bip @guest_list }
      end
    end
  end

  # PUT /guest_lists/1
  # PUT /guest_lists/1.json
  def update
    @guest_list = GuestList.find(params[:id])

    respond_to do |format|
      if @guest_list.update_attributes(params[:guest_list])
        format.html { redirect_to @guest_list, notice: 'Hui! Guest list was successfully updated.' }
        format.json { respond_with_bip(@guest_list) }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip(@guest_list) }
      end
    end
  end

  # DELETE /guest_lists/1
  # DELETE /guest_lists/1.json
  def destroy
    @guest_list = GuestList.find(params[:id])
    @guest_list.destroy

    respond_to do |format|
      format.html { redirect_to guest_lists_url }
      format.json { respond_with_bip @guest_list }
    end
  end

  def search
    authorize! :read, GuestList

    @guest_lists = GuestList.includes(:guests, :invitations).scoped

    @guest_lists = case params[:q]
                   when :nl.to_s
                     date = Chronic.parse(params[:nl], context: :future)
                     date = Date.today if date.wday == Date.today.wday
                     @guest_lists = @guest_lists
                       .approved.where('date = ?', date).alphabetic_by_date
                   when :active.to_s
                     @guest_lists = @guest_lists
                       .approved.active.alphabetic_by_date
                   when :active_pending.to_s
                     @guest_lists = @guest_lists
                       .active.pending.alphabetic_by_date
                   else
                     @guest_lists = @guest_lists
                       .approved.scoped.alphabetic_by_date
                   end

    respond_to do |format|
      format.html do
        render partial: 'list_by_date', locals: { guest_lists: @guest_lists }
      end
    end
  end

  def form
    @guest_list = GuestList.new
    authorize! :create, @guest_list
    render partial: 'form'
  end
end
