class ReservationsController < ApplicationController
  authorize_resource
  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.scoped

    if params[:date]
      @reservations = @reservations.where('date = ?', params[:date])
    end

    @reservations = @reservations
      .paginate(page: params[:page], per_page: 30)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reservations }
      format.js { render template: 'reservations/index.js.erb' }
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.json
  def new
    @reservation = Reservation.new
    if params[:table]
      @table = Table.find(params[:table])
      @reservation.table = @table
    end
    if params[:date]
      @reservation.date = params[:date]
    end
    if params[:guest_id] && (@guest = Guest.find_by_id params[:guest_id])
      @guest_data = @guest.id_name_tuple
    else
      @guest_data = []
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = Reservation.find(params[:id])
    @guest_data = @reservation.guest.try(:id_name_tuple)
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(params[:reservation])
    @guest_data = @reservation.guest.try(:id_name_tuple)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render json: @reservation, status: :created, location: @reservation }
      else
        format.html { render action: "new" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reservations/1
  # PUT /reservations/1.json
  def update
    @reservation = Reservation.find(params[:id])
    @guest_data = @reservation.guest.try(:id_name_tuple)

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end
end
