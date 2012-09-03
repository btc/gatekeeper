require 'will_paginate/array'

class GuestsController < ApplicationController
  load_and_authorize_resource except: [:full_name_search, :birthdays]
  # GET /guests
  # GET /guests.json
  def index

    @guests = Guest.includes(:guest_lists, :photos).scoped

    @guests = case
              when params[:q].present?
                @q = params[:q]
                @guests.by_first_last_gender.full_name_search(@q)
              else
                @guests.by_first_last_gender
              end

    @guests = @guests.paginate(per_page: 10, page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guests }
    end
  end

  # GET /guests/1
  # GET /guests/1.json
  def show
    @guest = Guest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/new
  # GET /guests/new.json
  def new
    @guest = Guest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guest }
    end
  end

  # GET /guests/1/edit
  def edit
    @guest = Guest.find(params[:id])
  end

  # POST /guests
  # POST /guests.json
  def create
    @guest = Guest.new(params[:guest])
    # assign current_user as creator
    @guest.creator = current_user
    # try to parse so that it gets saved in the case that form does not get submitted
    @guest.parse_birthday

    append_webcam_photo(params)

    respond_to do |format|
      if @guest.save
        format.html { redirect_to @guest, notice: 'Guest was successfully created.' }
        format.json { render json: @guest, status: :created, location: @guest }
      else
        format.html { render action: "new", status: 400 }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guests/1
  # PUT /guests/1.json
  def update
    @guest = Guest.find(params[:id])

    append_webcam_photo(params)

    respond_to do |format|
      if @guest.update_attributes(params[:guest])
        format.html { redirect_to @guest, notice: 'Guest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1
  # DELETE /guests/1.json
  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy

    respond_to do |format|
      format.html { redirect_to guests_url }
      format.json { head :no_content }
    end
  end

  # TODO manage permissions
  def full_name_search
    authorize! :lookup_names, Guest
    respond_to do |format|
      format.json do
        @guests = Guest.full_name_search params[:q]
        tuples = Guest.id_name_tuples @guests
        render json: tuples
      end
    end
  end

  def birthdays
    authorize! :read, Guest
    @birthday_guests = Guest.find_ordered_birthdays_for_the_next_month
  end

  private
  # if webcam id was submitted in hidden field, apply it to the guest object
  def append_webcam_photo(params)
    if params[:guest][:webcam_photo_id].present?
      @photo = Photo.find_by_id(params[:guest][:webcam_photo_id])
      @guest.photos << @photo if @photo.present?
    end
  end
end
