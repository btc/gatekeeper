class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(params[:photo])

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end

  # uploads images to public/uploads
  # paperclip (webcam_create) creates copies, so these uploads should be
  # deleted periodically
  def upload
    path = upload_path
    File.open(path, 'w') do |f|
      # must force encoding else ASCII conflict
      f.write request.raw_post.force_encoding('UTF-8')
      # store path to image for subsequent request
      flash[:image_path] = path
    end
    render :text => "ok"
  end

  def webcam_create
    @photo = Photo.new(params[:photo])

    respond_to do |format|

      error_response = Proc.new do
        format.html { render action: "new" and return }
        format.json do
          render json: @photo.errors, status: :unprocessable_entity
          return
        end
      end

      if flash[:image_path].present?
        # get path to image from previous request
        @photo.image = File.new(flash[:image_path])

        if @photo.save
          format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
          format.json { render json: @photo, status: :created, location: @photo }
        else
          error_response.call
        end

      else
        error_response.call
      end
    end

  end

  private

  def upload_path # is used in upload and create
    file_name = Photo.generate_file_name(extension: '.jpg')
    File.join(Rails.root, 'public', 'uploads', file_name)
  end
end
