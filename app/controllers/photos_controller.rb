class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.paginate(page: params[:page], per_page: 12)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photos_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @photo.update(photos_params)
        format.html { redirect_to @photo }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

private
  def photos_params
    params.require(:photo).permit(:title, :s3_key, :creator)
  end
end
