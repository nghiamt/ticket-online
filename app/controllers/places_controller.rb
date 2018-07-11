class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    unless current_user && current_user.admin?
      redirect_to root_url
    end
    @places = Place.order(created_at: :desc)
  end

  # GET /places/1
  # GET /places/1.json
  def show
    unless current_user && current_user.admin?
      redirect_to root_url
    end
  end

  # GET /places/new
  def new
    @place = Place.new
    respond_to do |format|
      format.js {render "form"}
    end
  end

  # GET /places/1/edit
  def edit
    respond_to do |format|
      format.js {render "form"}
    end
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render :show, status: :created, location: @place }
        format.js do
          @places = Place.order(created_at: :desc)
          render "index"
        end
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
        format.js do
          @errors = @place.errors
          render "layouts/errors"
        end
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
        format.js do
          @places = Place.order(created_at: :desc)
          render "index"
        end
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
        format.js do
          @errors = @place.errors
          render "layouts/errors"
        end
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :description, :image_url1, :image_url2, :image_url3)
    end
end
