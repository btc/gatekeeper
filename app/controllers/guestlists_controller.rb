class GuestlistsController < ApplicationController
  layout 'resources'
  # GET /guestlists
  # GET /guestlists.json
  def index
    @guestlists = Guestlist.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guestlists }
    end
  end

  # GET /guestlists/1
  # GET /guestlists/1.json
  def show
    @guestlist = Guestlist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guestlist }
    end
  end

  # GET /guestlists/new
  # GET /guestlists/new.json
  def new
    @guestlist = Guestlist.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guestlist }
    end
  end

  # GET /guestlists/1/edit
  def edit
    @guestlist = Guestlist.find(params[:id])
  end

  # POST /guestlists
  # POST /guestlists.json
  def create
    @guestlist = Guestlist.new(params[:guestlist])

    respond_to do |format|
      if @guestlist.save
        format.html { redirect_to @guestlist, notice: 'Guestlist was successfully created.' }
        format.json { render json: @guestlist, status: :created, location: @guestlist }
      else
        format.html { render action: "new" }
        format.json { render json: @guestlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guestlists/1
  # PUT /guestlists/1.json
  def update
    @guestlist = Guestlist.find(params[:id])

    respond_to do |format|
      if @guestlist.update_attributes(params[:guestlist])
        format.html { redirect_to @guestlist, notice: 'Guestlist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @guestlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guestlists/1
  # DELETE /guestlists/1.json
  def destroy
    @guestlist = Guestlist.find(params[:id])
    @guestlist.destroy

    respond_to do |format|
      format.html { redirect_to guestlists_url }
      format.json { head :no_content }
    end
  end
end
