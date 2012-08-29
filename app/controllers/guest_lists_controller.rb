class GuestListsController < ApplicationController
  load_and_authorize_resource
  layout 'resources'

  # GET /guest_lists
  # GET /guest_lists.json
  def index
    @guest_lists = GuestList.all

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

    respond_to do |format|
      if @guest_list.save
        format.html { redirect_to @guest_list, notice: 'Guest list was successfully created.' }
        format.json { respond_with_bip @guest_list }
      else
        format.html { render action: "new" }
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
        format.html { redirect_to @guest_list, notice: 'Guest list was successfully updated.' }
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
end
